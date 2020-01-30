Feature: all integrations print the correct messages

  Scenario:
    Given integration basic is running
    Then integration basic should print Hello World

  Scenario:
    Given integration routing is running
    Then integration routing should print Standard item: door
    Then integration routing should print !!Priority item: engine
