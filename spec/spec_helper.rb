require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.include IntegrationSpecHelper, :type => :request
    # Capybara.default_host = 'http://monhey.dev'

    OmniAuth.config.test_mode = true

    OmniAuth.config.add_mock(:facebook, {
      :info => {
        :name => 'zapnap',
        :email => "john@doe.com"
      },
      :uid => '12345'
    })

    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
  end

end

Spork.each_run do

end

