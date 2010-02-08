Feature: Manage Categories
	In order to better organize my expenses
	As an user
	I want to be able to categorize my expenses by custom categories
	
	Scenario: List of categories
		Given I have a category with title "My Category"
		When I go to the list of categories
		Then I should see "My Category"
	
	Scenario: Category info
		Given I have a category named "My category"
		  And I have the following expenses
		 | date      | amount | category_name |
		 | 2010-1-1  | -10    | My category   |
		 | 2010-2-1  | -10    | My category   |
		 | 2010-5-1  | -15    | My category   |
		 | 2010-10-1 | -35    | My category   |
		When I visit detail page for category "My category"
		Then I should see "-35"
	