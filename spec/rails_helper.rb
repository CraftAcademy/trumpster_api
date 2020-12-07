require "coveralls"
Coveralls.wear_merged!("rails")
require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "webmock/rspec"
require "stripe_mock"

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include ResponseJSON
  config.before(:each) do
    fixture = File.open("#{fixture_path}/random_quote.json").read
    stub_request(:get, "https://api.tronalddump.io/random/quote")
      .to_return(status: 200, body: fixture, headers: {})
    fixture = File.open("#{fixture_path}/search_results.json").read
    stub_request(:get, "https://api.tronalddump.io/search/quote?query=barack")
      .to_return(status: 200, body: fixture, headers: {})
  end
  config.before(:each) do
    StripeMock.start
  end
  config.after(:each) do
    StripeMock.stop
  end
end
