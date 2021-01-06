ENV['RAILS_ENV'] ||= 'test'

require_relative "../config/environment"
require "rack/test"


if ENV['COVERAGE'] == 'true'
  require "simplecov"

  if ENV['CI'] == 'true'
    require 'codecov'
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
    puts "required codecov"
  end

  SimpleCov.start
  puts "required simplecov"
end

# https://github.com/DatabaseCleaner/database_cleaner#safeguards
DatabaseCleaner.allow_remote_database_url = true
DatabaseCleaner[:sequel].db = Sequel.connect(ENV.fetch("DATABASE_URL"))

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
