@Commerce

Feature: Customer wishlist
  As a big commerce admin
  I should be able to create a customer and add a product

  Scenario: As a big commerce admin want to add an customer and product to his wishlist
    Given I open big commerce Control panel page
    When I log in with a valid "username" and "password"
    Then I add customer with the following details
      | First Name | Last Name | Email Address|
      | Ravi       | Arkasali  | ravi.arkasali@bigcommerce.com |
    Then I update customer details
      | Company Name | Phone Number |
      | Big Commerce | 61445554443  |

  Scenario: As a customer i want to log in to big commerce and add a product to my wishlist
     Given I open big commerce live store page
     When I select the product from the list
     Then I login to store to add the to my wish list

  Scenario: As a big commerce admin i want to remove customer
    Given I open big commerce Control panel page
    When I log in with a valid "username" and "password"
    Then I remove a customer
