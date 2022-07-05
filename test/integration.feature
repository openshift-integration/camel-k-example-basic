Feature: Basic

  Background:
    Given Camel K resource polling configuration
      | maxAttempts          | 200   |
      | delayBetweenAttempts | 2000  |

  Scenario: Run Basic Camel-K integration
    When load Camel K integration Basic.java
    Then Camel K integration basic should be running
    And Camel K integration basic should print Hello World

  Scenario: Run Routing Camel K integration
    Given Camel K integration property file routing.properties
    When load Camel K integration Routing.java
    Then Camel K integration routing should be running
    Then Camel K integration routing should print Standard item: door
    Then Camel K integration routing should print !!Priority item: engine
