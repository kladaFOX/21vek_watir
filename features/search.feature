Feature: 21vek test search
  Scenario: searching something
    Given a user goes to 21vek home page
    When a user search for "телефон"
    And put price filter from 100 to 200
    And put 2 telephone in the cart
    Then 21vek should return "1 товар".
