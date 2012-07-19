@api_server
Feature: Developer signs in
  In order to be securely identified to pairzone
  As a developer
  I want the pairzone gem to use my public key to get an API key from pairzone

  Scenario: Derek signs in for first time
    When "derek" runs "pairzone info" in test mode with no api key
    And "derek" supplies his credentials
    Then his API key is saved
    And he sees information about his pairzone account
