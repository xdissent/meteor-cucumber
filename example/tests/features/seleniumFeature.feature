
@selenium
Feature: Home page says hello for selenium
  In order to see my welcome message
  As a visitor to the site
  I want to see the words "Welcome to example."
 
  Scenario: Go to home page with selenium
    Given I am a website visitor using selenium
    When I go to the home page with selenium
    Then I should see "Welcome to example." using selenium
