require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Expense do
  before(:each) do
    Expense.destroy_all
    @valid_attributes = {
    	:description => "Sample expense",
    	:amount => "100.0",
    	:category => "Altro"
    }
		
		e1 = Expense.create!(:description => "First", :amount => 0, :date => Date.parse("2009/01/01"),
		        :category => "Altro")
  	e2 = Expense.create!(:description => "Second", :amount => 10, :date => Date.parse("2009/02/01"),
  	        :category => "Altro", :bancomat => true)
  	e3 = Expense.create!(:description => "Third", :amount => 20, :date => Date.parse("2009/03/01"),
  	        :category => "Altro", :bancomat => false)
		
  end

	after(:each) do
		
	end

  it "should create a new instance given valid attributes" do
    Expense.create!(@valid_attributes)
  end
  
  it "should not be valid without description" do
  	e = Expense.new()
  	e.should_not be_valid
  	e.errors_on(:description).should_not be_nil
  end
  
  it "should not be valid with non numerical amounts" do
  	e = Expense.new(:description => "Sample description")
  	e.amount = "Gnagno"
  	e.should_not be_valid
  end
  
  it "should retrieve expenses in a given month" do
  	expenses_of_february = Expense.find_by_year_month(:year => 2009, :month => 2)
  	expenses_of_february.size.should eql(1)
  end
 
	it "should retrieve expenses in a given month passing a date" do
  	expenses_of_february = Expense.find_by_year_month(:date => Date.parse("2009/02/01"))
  	expenses_of_february.size.should eql(1)
	end
  
	it "should be able to navigate expenses forward and backward by month" do
		expenses_of_march = Expense.find_by_year_month(:date => Date.parse("2009/02/01").month_after)
  	expenses_of_march.size.should eql(1)	
		expenses_of_january = Expense.find_by_year_month(:date => Date.parse("2009/02/01").month_before)
  	expenses_of_january.size.should eql(1)
	end
  
  it "should calculate correctly the average value for a given month" do
    # simple case: 0
    Expense.average_for_month(2009, 1, 0).should eql(0.0)
    # other case: 30 days-month, 900 euro: 30 euro/day
    Expense.average_for_month(2009, 11, 900).should eql(30.0)
    # and now, < 0
    Expense.average_for_month(2009, 11, -900).should eql(-30.0)
  end  
  
  it "should calculate correctly the average value for the current month" do
    Date.stub!(:today).and_return(Date.parse("2009/01/10"))
    Expense.average_for_current_month(0).should eql(0.0)
    Expense.average_for_current_month(900).should eql(90.0)
    Expense.average_for_current_month(-900).should eql(-90.0)
  end  
  
  
  it "should calculate correctly the amount of bancomat expenses" do
    Expense.total_for_bancomat_in(Expense.all).should eql(10.0)
  end
  
  it "should calculate correctly a monthly prevision" do
    Date.stub!(:today).and_return(Date.parse("2009/01/01"))
    
    Expense.prevision_for_current_month(0).should eql(0.0)
    Expense.prevision_for_current_month(-10).should eql(-310.0)
    
    Date.stub!(:today).and_return(Date.parse("2009/01/10"))
    Expense.prevision_for_current_month(-100).should eql(-310.0)
    Expense.prevision_for_current_month(0).should eql(0.0)
  end
  
end
