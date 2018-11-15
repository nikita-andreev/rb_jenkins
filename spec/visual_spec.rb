require 'spec_helper'
require 'eyes_selenium'

RSpec.describe 'GITHUB' do
  it 'index page' do
    begin
      desired_caps = Selenium::WebDriver::Remote::Capabilities.chrome
      desired_caps[:username] = ENV['SAUCE_USERNAME']
      desired_caps[:accesskey] = ENV['SAUCE_ACCESS_KEY']
      driver = Selenium::WebDriver.for :remote, url: 'http://ondemand.saucelabs.com/wd/hub', desired_capabilities: desired_caps
      eyes = Applitools::Selenium::Eyes.new
      eyes.api_key = ENV['APPLITOOLS_API_KEY']
      eyes.log_handler = Logger.new(STDOUT).tap do |l|
        l.level = Logger::FATAL
      end
    
      eyes_driver = eyes.open(driver: driver, app_name: 'MS Azure DevOps', test_name: 'Github index page', viewport_size: {width: 800, height: 600})
      eyes_driver.get('http://github.com')
      eyes.check_window('window')
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts eyes.batch.id
    rescue StandardError => e
      p e.message
    ensure 
      eyes.close
    end
  end 
end
