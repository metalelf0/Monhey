require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesController do

	describe "index action" do
 	  
 	  integrate_views
 	
 		before(:each) do
 		  Expense.delete_all 			
 			@e1 = mock_model(Expense, :description => "First", :amount => 0, :date => Date.parse("2009/01/01"), :category => "",
 			:bancomat => true, :ufficio => true, :buoni => 0)
  		@e2 = mock_model(Expense, :description => "Second", :amount => 10, :date => Date.parse("2009/02/01"), :category => "",
 			:bancomat => true, :ufficio => true, :buoni => 0)
  		@e3 = mock_model(Expense,:description => "Third", :amount => 20, :date => Date.parse("2009/03/01"), :category => "",
 			:bancomat => true, :ufficio => true, :buoni => 0)
 			Expense.stub(:categories).and_return(["Altro"])
 			Expense.stub(:all).and_return([@e1, @e2, @e3])
 			Expense.stub(:find_by_year_month).and_return([@e1])
 		end
 	
 		it "should receive a success response and show all the entries" do
		  get :index
		  response.should be_success
		  response.should have_tag('tr.expense-row', :count => 1)
		end
		
		it "should show only the entries for a given month, if params are given" do
			get :index, :year => 2009, :month => 2
		  response.should be_success
		  assigns[:expenses].should have(1).expenses
		end
 
    it "should include 10 edit fields" do
      get :index
      response.should be_success
      response.should have_tag('tr.insert_rowA', :count => 5)
      response.should have_tag('tr.insert_rowB', :count => 5)      
    end
    
    it "should show a line with the totals" do
      Expense.stub(:find_by_year_month).and_return([@e1, @e2, @e3])
      
      get :index
      response.should be_success
      response.should have_tag('tr.totals')
      response.should have_tag('td.total-amount', :text => "30")
    end
 
	end

end
