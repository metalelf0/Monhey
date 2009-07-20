require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesController do

	describe "index action" do
 	
 		before(:each) do
 			
 			e1 = mock_model(Expense, :description => "First", :amount => 0, :date => Date.parse("2009/01/01"))
  		e2 = mock_model(Expense, :description => "Second", :amount => 10, :date => Date.parse("2009/02/01"))
  		e3 = mock_model(Expense,:description => "Third", :amount => 20, :date => Date.parse("2009/03/01"))
 			Expense.stub(:all).and_return([e1, e2, e3])
 			Expense.stub(:find_by_year_month).and_return([e1])
 		end
 	
 		it "should receive a success response" do
		  get :index
		  response.should be_success
		end
		
		it "should show only the entries for a given month, if params are given" do
			get :index, :year => 2009, :month => 2
		  response.should be_success
		  assigns[:expenses].should have(1).expenses
		end
 
	end

end
