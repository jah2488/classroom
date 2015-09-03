# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/page-regression'
require 'database_cleaner'
require 'pundit/rspec'
require 'codeclimate-test-reporter'
require 'support/pundit'

require 'support/features/session_helpers.rb'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
ActiveRecord::Migration.maintain_test_schema!
CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Devise::TestHelpers, type: :controller
  config.include PunditViewPolicy, type: :view
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

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

  config.infer_spec_type_from_file_location!
end
