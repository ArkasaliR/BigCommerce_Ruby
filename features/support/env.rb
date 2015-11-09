require 'rspec/expectations'
require 'capybara/cucumber'
require 'i18n'
require 'active_support'
require 'active_support/core_ext'

# We're going to load the paths to locale files,
I18n.load_path += Dir[File.join(File.dirname(__FILE__), '../../config', 'locales', '*.yml').to_s]
I18n.enforce_available_locales = false

if ENV['FORCE_SELENIUM'] == "true"
  require 'capybara'
  require "selenium-webdriver"
  if ENV['LOCAL'] == "true"
    ENV['NO_PROXY'] = '127.0.0.1'
  else
    Capybara.register_driver :selenium do |app|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = 600
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile.assume_untrusted_certificate_issuer = false
      profile.proxy = Selenium::WebDriver::Proxy.new(:no_proxy => true) unless ENV['WITH_PROXY']
      if (ENV['BROWSER'] == 'chrome')
        Capybara::Selenium::Driver.new(app, :browser => :chrome, :http_client => client)
      else
        Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile, :http_client => client)
      end
    end
  end

  Capybara.javascript_driver = :selenium
  Capybara.default_driver = :selenium

Capybara.default_selector = :css
Capybara.default_wait_time = 60
if ENV['WAIT_TIME']
  Capybara.default_wait_time = ENV['WAIT_TIME'].to_i
end

World(RSpec::Matchers)
end