Feature: all integrations print the correct messages

  Background:
    Given Disable auto removal of Kubernetes resources
    Given load Kubernetes custom resource operatorgroup.yaml in operatorgroups.operators.coreos.com
    Given load Kubernetes custom resource camel-k-subscription.yaml in subscriptions.operators.coreos.com

  Scenario: Integration basic prints Hallo World
    Given Camel-K integration basic is running
    Then Camel-K integration basic should print Hello World

  Scenario: Integration routing prints items
    Given Camel-K integration routing is running
    Then Camel-K integration routing should print Standard item: door
    Then Camel-K integration routing should print !!Priority item: engine
