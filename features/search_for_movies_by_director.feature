Feature: search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and serach on director information in movies I enter

  Background: movies in database

    Given the following movies exist:
      | title        | rating | director     | release_date |
      | Star Wars    | PG     | George Lucas | 1977-05-25   |
      | Blade Runner | PG     | Ridley Scott | 1982-06-25   |
      | Alien        | R      |              | 1979-05-25   |
      | THX-1138     | R      | George Lucas | 1971-03-11   |

  Scenario: visit home page of Rotten Potatoes
    When I go to the home page of Rotten Potatoes
    Then I should see "Star Wars"
    Then I should see "Blade Runner"
    Then I should see "Alien"
    Then I should see "THX-1138"

  Scenario: sort the movie list on home page by title
    When I go to the home page of Rotten Potatoes
    And  I follow "Movie Title"
    Then I should see "Alien" ordering "1"
    And  I should see "Blade Runner" ordering "2"
    And  I should see "Star Wars" ordering "3"
    And  I should see "THX-1138" ordering "4"

    When I go to the home page of Rotten Potatoes
    Then I should see "Alien" ordering "1"
    And  I should see "Blade Runner" ordering "2"
    And  I should see "Star Wars" ordering "3"
    And  I should see "THX-1138" ordering "4"

  Scenario: filter a specific rating of movies
    When I go to the home page of Rotten Potatoes
    Then I should see "Alien"

    When I uncheck the option with ID "ratings_R"
    Then I press "Refresh"
    And  I should not see "Alien"

    When I go to the home page of Rotten Potatoes
    And  I should not see "Alien"

  Scenario: visit a movie's detail page
    When I go to the details page for "Star Wars"
    Then I should see "Star Wars"
    Then I should see "PG"
    Then I should see "George Lucas"
    Then I should see "May 25, 1977"
    But  I should not see "Blade Runner"
    But  I should not see "Alien"
    But  I should not see "THX-1138"

  Scenario: add director to existing movie
    When I go to the details page for "Alien"
    But  I should not see "Ridley Scott"

    When I go to the edit page for "Alien"
    And  I fill in "Director" with "Ridley Scott"
    And  I press "Update Movie Info"
    Then the director of "Alien" should be "Ridley Scott"

    When I go to the details page for "Alien"
    Then I should see "Ridley Scott"

  Scenario: add a new movie
    When I go to the home page of Rotten Potatoes
    But  I should not see "Raiders of the Lost Ark"

    When I follow "Add new movie"
    Then I should see "Create New Movie"
    And  I fill in "Title" with "Raiders of the Lost Ark"
    And  I fill in "Director" with "George Lucas"
    And  I select "PG" in "Rating"
    And  I select date "1987/12/11" in "Released On"
    And  I press "Save Changes"

    When I go to the home page of Rotten Potatoes
    But  I should see "Raiders of the Lost Ark"

    When I go to the details page for "Raiders of the Lost Ark"
    Then I should see "Raiders of the Lost Ark"
    Then I should see "PG"
    Then I should see "George Lucas"
    Then I should see "December 11, 1987"
    But  I should not see "Star Wars"
    But  I should not see "Blade Runner"
    But  I should not see "Alien"
    But  I should not see "THX-1138"

    When I go to the director page of "George Lucas"
    Then I should see "Raiders of the Lost Ark"

  Scenario: destroy a movie
    When I go to the home page of Rotten Potatoes
    Then I should see "Star Wars"

    When I go to the details page for "Star Wars"
    Then I press "Delete"

    When I go to the home page of Rotten Potatoes
    But  I should not see "Star Wars"

  Scenario: find movie with same director
    Given I am on the details page for "Star Wars"
    When  I follow "Find All Movies Directed by 'George Lucas'"
    Then  I should be on the director page of "George Lucas"
    Then  I should see "Star Wars"
    And   I should see "THX-1138"
    But   I should not see "Blade Runner"
    But   I should not see "Alien"

  Scenario: can't find similar movies if we don't know director (sad path)
    Given I am on the details page for "Alien"
    Then  I should not see "Ridley Scott"
    When  I follow "Find All Movies Directed by ''"
    Then  I should be on the director page of ""
    And   I should see "'Alien' has no director info."