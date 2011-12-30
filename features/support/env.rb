require 'rubygems'
require "bundler/setup"

require 'cucumber'
require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'cucumber/web/tableish'

require 'capybara'
require 'capybara/cucumber'
require 'capybara/session'

require 'rspec'
require 'selenium-webdriver'

Capybara.default_selector = :css
Capybara.default_wait_time = 60

#Swap this for the environment you are testing
Capybara.app_host = ENV['FUNCTIONAL_TESTING_HOST'] || "http://localhost"

Capybara.default_driver = :selenium

custom_firefox_profile = Selenium::WebDriver::Firefox::Profile.new
# this setting prevents the loading of images which speeds things up dramatically
#custom_firefox_profile["permissions.default.image"] = 2

if ENV['REMOTE_SELENIUM'] == true || ENV['REMOTE_SELENIUM'] == "true"
  Capybara.register_driver :selenium do |app|
    remote_capabilities = Selenium::WebDriver::Remote::Capabilities.firefox
    remote_capabilities.firefox_profile = custom_firefox_profile
    Capybara::Selenium::Driver.new(app,
                                   :browser => :remote,
                                   :desired_capabilities => remote_capabilities,
                                   :url => "#{ENV['REMOTE_SELENIUM_HOST']}:5555/wd/hub")
  end
else
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   :profile => custom_firefox_profile)
  end
end
