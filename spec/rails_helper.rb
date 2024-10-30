# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require_relative 'swagger_helper'
require 'json_matchers/rspec'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

support_dir = File.join(File.dirname(__FILE__), 'support/**/*.rb')
Dir[File.expand_path(support_dir)].each do |file|
  require file unless file[/\A.+_spec\.rb\z/]
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

JsonMatchers.schema_root = 'spec/support/api/schemas'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.extend Helpers::ResponseSchema, type: :request
  config.include FactoryBot::Syntax::Methods
end
