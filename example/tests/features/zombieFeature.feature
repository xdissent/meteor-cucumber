
@zombie
Feature: Home page says hello for zombie
  In order to see my welcome message
  As a visitor to the site
  I want to see the words "Welcome to example."
 
  Scenario: Go to home page with zombie
    Given I am a website visitor using zombie
    When I go to the home page with zombie
    Then I should see "Welcome to example." using zombie
