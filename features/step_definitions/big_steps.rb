
## This step will take you to the Control panel.
Given(/^I open big commerce Control panel page$/) do
  visit(big_commerce)
end

## This step will login the big commerce admin in the control panel.
When(/^I log in with a valid "([^"]*)" and "([^"]*)"$/) do |arg1, arg2|
  step %Q{I fill in "user_email" with "#{I18n.t 'bigcommerce.login.Email'}"}
  step %Q{I fill in "user_password" with "#{I18n.t 'bigcommerce.login.password'}"}
  step %Q{I press "Log in"}
end

##This step big commerce admin will be able to add/create the customer with the relevant details as provided.
Then(/^I add customer with the following details$/) do |table|
  find('#nav-customers').click
  step %Q{I follow "Add"}
  fill_table(table)
end

##This method will fill the details in adding a new customer and his all required details.
def fill_table(table)
  row = table.hashes.first
  add_details(row)
  more_details
end

##This method add the details of the customer.
def add_details(row)
  step %Q{I fill_in "custFirstName" with "#{row['First Name']}" within frame "content-iframe"}  if row['First Name']
  step %Q{I fill_in "custLastName" with "#{row['Last Name']}" within frame "content-iframe"}  if row['Last Name']
  step %Q{I fill_in "custEmail" with "#{row['Email Address']}" within frame "content-iframe"}  if row['Email Address']
  step %Q{I fill_in "custCompany" with "#{row['Company Name']}" within frame "content-iframe"}  if row['Company Name']
  step %Q{I fill_in "custPhone" with "#{row['Phone Number']}" within frame "content-iframe"}  if row['Phone Number']
end

##This method will will check the availability ,set password and save the customer details.
def more_details
  step %Q{I select "Check Availability" within frame "content-iframe"}
  step %Q{I fill_in "custPassword" with "#{I18n.t 'bigcommerce.login.login_password'}" within frame "content-iframe"}
  step %Q{I fill_in "custPasswordConfirm" with "#{I18n.t 'bigcommerce.login.confirm_password'}" within frame "content-iframe"}
  step %Q{I select "Save & Exit" within frame "content-iframe"}
end

def remove_cookies
  browser = Capybara.current_session.driver.browser
  browser.manage.window.resize_to(1600,800)
  browser.manage.delete_all_cookies
end

##This step big commerce admin will be able to update the customer details.
Then(/^I update customer details$/) do |table|
  within_frame("content-iframe")do
    find(:xpath, "//tr/td[contains(@class,'customer-name')]/a").click
  end
  fill_table(table)
  page.find('.triangle-down').click
  step %Q{I follow "Log out" within "ul.dropdown-menu"}
  remove_cookies
end

##This step will take you to the store URL.
Given(/^I open big commerce live store page$/) do
  visit(big_store)
end

##This step the user can select the product and trigger add to wishlist.
When(/^I select the product from the list$/) do
  first('.ProductDetails > a').click
  step %Q{I press "Add to Wishlist"}
end

##This step the user is logging in to store and add to his wishlist.
Then(/^I login to store to add the to my wish list$/) do
  step %Q{I fill in "login_email" with "#{I18n.t 'bigcommerce.store.Email'}"}
  step %Q{I fill in "login_pass" with "#{I18n.t 'bigcommerce.store.password'}"}
  step %Q{I press "Sign In"}
  step %Q{I should see "The item has been added to your wish list."}
  step %Q{I follow "Sign out"}
  remove_cookies
end
