Feature: Manage Expenses
	In order to keep track of my expenses
	As an user
	I want to be able to insert and retrieve expenses from the DB
	
	Scenario: Expenses list
		Given I have a category named Stuff
			And I have an account named Bancomat
			And I have expenses with description Pizza, Pallone in category Stuff and in account Bancomat
		When I go to the list of expenses
		Then I should see "Pizza"
			And I should see "Pallone"