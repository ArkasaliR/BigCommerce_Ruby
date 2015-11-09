require 'capybara'
require 'capybara/rspec/matchers'

World(Capybara::DSL)
World(Capybara::RSpecMatchers)

Before do
  Capybara.use_default_driver
end

After do
  Capybara.reset_sessions!
end
