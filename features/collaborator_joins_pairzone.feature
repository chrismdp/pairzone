@api_server
Feature: Collaborator joins pairzone
  In order to pair on writing code
  As a collaborator
  I want to join existing pairzones that I am listed as a collaborator on

  Scenario: Developer starts, then joins pairzone
    Given "bob" has already started a pairzone
    When "bob" runs "pairzone join bob-aruba" in test mode
    Then "bob" should be connected to "bob-aruba"

  Scenario: Collaborator joins pairzone
    Given "bob" has already started a pairzone with "derek" as a collaborator
    When "derek" runs "pairzone join bob-aruba" in test mode
    Then "derek" should be connected to "bob-aruba"

  Scenario: Collaborator cannot join pairzone where they're not listed
    Given "bob" has already started a pairzone
    When "derek" runs "pairzone join bob-aruba" in test mode
    Then "derek" should not be able to connect
