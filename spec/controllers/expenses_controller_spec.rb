require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'webrat'

describe ExpensesController do

	describe "index action" do
 	
 		before(:all) do
 			@altro = mock_model(Category, :name => "Altro")
 			
 			@bancomat = mock_model(Account, :name => "Bancomat")
 			
 			@first = mock_model(Expense, 
 			  :description => "First",
 			  :amount => 0,
 			  :date => Date.new(2009,1,1),
 			  :category => @altro, 
 			  :account => @bancomat, 
 			  :ufficio => true, 
 			  :buoni => 1)
 			
  		@second = mock_model(Expense, 
  		  :description => "Second", 
  		  :amount => 10, 
  		  :date => Date.new(2009,2,1), 
  		  :category => @altro, 
  		  :account => @bancomat, 
  		  :ufficio => true, 
  		  :buoni => 2)
  		
  		@third = mock_model(Expense,
  		  :description => "Third", 
  		  :amount => 20, 
  		  :date => Date.new(2009,3,1), 
  		  :category => @altro, 
  		  :account => @bancomat, 
  		  :ufficio => true, 
  		  :buoni => 3)

      @bancomat.stub!(:is_bancomat?).and_return true      
 			
 			Category.stub(:all).and_return([@altro])
 			Expense.stub(:all).and_return([@first, @second, @third])
 			Expense.stub(:find_by_year_month).and_return([@first])
 		end
 	
 		it "should receive a success response and show all the entries" do
		  get :index
		  response.should be_success
      assigns[:expenses].should eql [@first]
		end
		
		it "should show only the entries for a given month" do
			get :index, :year => 2009, :month => 1
		  response.should be_success
		  assigns[:expenses].should eql [@first]
		end
 
 		it "should show only the entries for a given month and category" do
      Expense.should_receive(:find_by_year_month_and_category).and_return([])
			get :index, :year => 2009, :month => 2, :category_name => "A category without expenses"
		  response.should be_success
		  assigns[:expenses].should have(0).expenses
		end
  
	end

end
