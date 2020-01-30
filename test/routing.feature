Feature: routing integration routes items correctly

  Scenario:
    Given integration routing is running
    Then integration routing should print Standard item: door
    Then integration routing should print !!Priority item: engine
