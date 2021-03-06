@announce
Feature: Developer starts pairzone

  Scenario:
    Given I have a local git repository
    When "bob" runs "pairzone start" in test mode
    Then a new pairzone is started for "bob"
    And the code in my current directory is pushed to the server
    And an SSH connection is made to my new pairzone
    And the code is downloaded to a "pairzone" branch when I quit the session

  Scenario: Developer starts pairzone in the background
    Given I have a local git repository
    When "bob" runs "pairzone start --background" in test mode
    Then a new pairzone is started for "bob" in the background

  Scenario: Developer rejoins previously started pairzone
    Given I have a local git repository
    When "bob" runs "pairzone start --background" in test mode
    And "bob" runs "pairzone start" in test mode
    Then "bob" should be connected to "bob-aruba"
