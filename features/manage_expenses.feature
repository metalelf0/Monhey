Feature: Manage Expenses
	In order to keep track of my expenses
	As an user
	I want to be able to insert and retrieve expenses from the DB
	
	Scenario: Expenses list
		Given I have expenses with description Pizza, Pallone
		When I go to the list of expenses
		Then I should see "Pizza"
			And I should see "Pallone"
			
	@focus		
	Scenario: Create valid expense
		Given I have a category named "Stuff"
			And I have an account named "Account"
			And I have no expenses
		When I go to the list of expenses
			And I fill in "elem1_amount" with "10"
			And I fill in "elem1_buoni" with "0"
			And I fill in "elem1_description" with "Pallone"
			And I press "Save"
		Then I should see "1 expenses correctly saved" 
			And I should have 1 expense
