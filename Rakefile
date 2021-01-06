require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc "load the environment"
task :environment do
  ENV["DATABASE_URL"] ||= "sqlite://todo_#{ENV.fetch('RACK_ENV')}.db"
  require_relative "./config/environment"
end

desc "run the app"
task :server => [:environment] do
  sh "rackup"
end

desc "reset the DB to a pristine state"
task :nuke_db => [:environment] do
  db_repo = DbRepo.from_database_url_env_var
  db_repo.nuke!
  db_repo.prep!
end

task :default => :spec
