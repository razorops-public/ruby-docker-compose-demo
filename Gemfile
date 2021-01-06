source "https://rubygems.org"

gem "rake"
gem "rack", "~> 2"
gem "sinatra"
gem "sequel"
gem "sinatra-contrib"
gem "require_all"

group :production do
  gem "pg"
end

group :development, :test do
  gem "rspec"
  gem "rack-test"
  gem "sqlite3"
  gem 'database_cleaner-sequel'
  gem "simplecov"
end
