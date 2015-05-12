Feature: Starting the game
  In order to play battleships
  As a nostalgic player
  I want to start a new game

  Scenario: Registering
    Given I am on the homepage
    When I follow "New Game"
    Then I should see "What's your name?"

  Scenario: Launching Game
    Given I have clicked on "New Game"
    When I submit my name : "Alex"
    Then I should see my name : "Alex"