  ##This step the big commerce admin can remove the customer from having access to store.
  ##Please note: The purpose of this step is,as the customer creation data is stubbed the test should not fail on any number of executions this method is included..
  Then(/^I remove a customer$/) do
    find('#nav-customers').click
    step %Q{I follow "View"}
    within_frame("content-iframe")do
      page.find('label[for=select-all]').click
      page.execute_script('$("button[name=SaveContinueButton1]").click()')
      step %Q{I press "Ok"}
    end
  end
