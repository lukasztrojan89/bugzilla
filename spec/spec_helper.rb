ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
require 'simplecov-rcov'
SimpleCov.start 'rails'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter if ENV['COVERAGE']

require File.expand_path("../../config/environment", __FILE__)
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

require 'rspec/rails'
require 'rspec/autorun'

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    DatabaseCleaner.clean_with :truncation
  end

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

# Run specs in random order to surface order dependencies. If you find an
# order dependency and want to debug it, you can fix the order by providing
# the seed, which is printed after each run.
# --seed 1234
  config.order = "random"

  config.include Devise::TestHelpers, :type => :controller
end