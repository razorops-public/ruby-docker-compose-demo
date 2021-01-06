require "sinatra"
require "json"
require "logger"

class TodoApp < Sinatra::Application
  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  configure :development, :test do
    $logger = Logger.new(STDOUT)
  end
  
  error do
    if err = request.env["sinatra.error"]
      $logger.info "***** BOOM *****"
      $logger.info err.message
      $logger.info "\n" + err.backtrace[0..20].join("\n")
    end
  end

  def json_body
    JSON.parse(request.env["rack.input"].read, :symbolize_names => true)
  end

  def todos_url
    uri("/todos")
  end

  def todo_url(todo)
    uri("/todos/#{todo.fetch(:uid)}")
  end

  def todo_repr(todo)
    todo.merge({
      "href" => todo_url(todo),
      "url" => todo_url(todo),
    })
  end

  get "/" do
    redirect todos_url
  end

  options "/todos" do
    headers "access-control-allow-methods" => "GET,HEAD,POST,DELETE,OPTIONS,PUT"
  end

  get "/todos" do
    current_store.all_todos.map { |t| todo_repr(t) }.to_json
  end

  post "/todos" do
    new_todo = json_body
    stored_todo = current_store.add_todo(new_todo)
    headers["Location"] = todo_url(stored_todo)
    status 201
    todo_repr(stored_todo).to_json
  end

  delete "/todos" do
    current_store.clear!
    status 204
  end

  def lookup_todo_or_404
    todo = current_store[params[:todo_uid]]
    halt 404 if todo.nil?
    todo
  end

  options "/todos/:todo_uid" do
    headers "access-control-allow-methods" => "GET,PATCH,HEAD,DELETE,OPTIONS"
  end

  get "/todos/:todo_uid" do
    todo_repr(lookup_todo_or_404).to_json
  end

  delete "/todos/:todo_uid" do
    current_store.delete(params[:todo_uid])
    status 204
  end

  patch "/todos/:todo_uid" do
    todo = lookup_todo_or_404
    todo.merge!(json_body)
    @repo[todo.fetch(:uid)] = todo
    todo_repr(todo).to_json
  end

  def current_store
    @current_store ||= begin
        if ENV["DATABASE_URL"]
          $logger.info("Loading todo store from #{ENV["DATABASE_URL"]}")
          DbRepo.from_database_url_env_var
        else
          $logger.info("Using in-memory hash to store todos")
          TodoRepo.new
        end
      end
  end
end
