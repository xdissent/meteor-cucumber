
@protractor
Feature: Home page says hello for protractor
  In order to see my welcome message
  As a visitor to the site
  I want to see the words "Welcome to example."
 
  Scenario: Go to home page with protractor
    Given I am a website visitor using protractor
    When I go to the home page with protractor
    Then I should see "Welcome to example." using protractor
