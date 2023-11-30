source "https://rubygems.org"

if Gem::Version.new(Bundler::VERSION) < Gem::Version.new('2.0.0')
  abort "Bundler version >= 2.0.0 is required"
end

ruby "~> 3"

gem "rake"
gem "rack", "~> 2"
gem "sinatra", "~> 2.0"
gem "sequel"
gem "sinatra-contrib"
gem "require_all"

group :production do
  gem "pg", '~> 1.2'
end

group :development, :test do
  gem "rspec"
  gem "rack-test"
  gem "sqlite3"
  gem 'database_cleaner-sequel'
  gem "simplecov"
end
