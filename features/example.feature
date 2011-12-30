Feature: BookRenter Search for "Programming Books"
  As a developer that wants to use a real language that supports threading and concurrency
  I should be able to search "Concurrent Programming in Java" on BookRenter

  @resync_off
  Scenario: Search "Programming Books" on our home page
    Given I go to the home page
    When I fill in "search_field" with "Concurrent Programming in Java"
    And I press "Find Book"
    Then I should see "Concurrent Programming In Java Textbooks"

  Scenario: Search for a particular ISBN on our home page
    Given I go to the home page
    When I fill in "search_field" with "9780201310092"
    And I press "Find Book"
    And I press "Add to Cart"
    And I follow "View and edit your cart"
	 
