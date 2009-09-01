require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Expense do
  before(:each) do
    Expense.delete_all
    Category.delete_all
    Account.delete_all
    
    @stipendio = Category.create!(:name => "Stipendio")
  	@altro = Category.create!(:name => "Altro")
    
    @bancomat = Account.create!(:name => "Bancomat")
    @contanti = Account.create!(:name => "Contanti")
    
    @valid_attributes = {
    	:description => "Sample expense",
    	:amount => "100.0",
    	:category => @altro
    }
		
	  e1 = Expense.create!(:description => "First", :amount => 0, :date => Date.new(2009,1,1), :category => @altro, :account => @contanti)
  	e2 = Expense.create!(:description => "Second", :amount => 10, :date => Date.new(2009,2,1), :category => @altro, :account => @bancomat)
  	e3 = Expense.create!(:description => "Third", :amount => 20, :date => Date.new(2009,3,1), :category => @altro, :account => @contanti)
  	

		
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
  	expenses_of_february = Expense.find_by_year_month(:date => Date.new(2009, 2, 1))
  	expenses_of_february.size.should eql(1)
  end
  
	it "should be able to navigate expenses forward and backward by month" do
		expenses_of_march = Expense.find_by_year_month(:date => (Date.new(2009,2,1) >> 1))
  	expenses_of_march.size.should eql(1)	
		expenses_of_january = Expense.find_by_year_month(:date => (Date.new(2009,2,1) << 1))
  	expenses_of_january.size.should eql(1)
	end
  
  it "should calculate correctly the average value for a given month" do
    # simple case: 0
    Expense.average_for_month(Date.new(2009, 1, 1)).should eql(0.0)
    
    # other case: 30 days-month, 900 euro: 30 euro/day
    Expense.stub!(:total_for_month).with(Date.new(2009, 11, 1)).and_return(900)
    Expense.average_for_month(Date.new(2009, 11, 1)).should eql(30.0)
    
    Expense.stub!(:total_for_month).with(Date.new(2009, 11, 1)).and_return(-900)
    Expense.average_for_month(Date.new(2009, 11, 1)).should eql(-30.0)
  end  
  
  it "should calculate correctly the total for a given month" do
    Expense.total_for_month(Date.new(2009, 1, 1)).should eql(0.0)
    Expense.total_for_month(Date.new(2009, 2, 1)).should eql(10.0)
    Expense.total_for_month(Date.new(2009, 3, 1)).should eql(20.0)
  end
  
  it "should calculate correctly the average value for the current month" do
    Date.stub!(:today).and_return(Date.new(2009,1,1))
    Expense.average_for_current_month.should eql(0.0)
    
    Date.stub!(:today).and_return(Date.new(2009,1,10))
    Expense.stub!(:total_for_current_month).and_return(900)
    Expense.average_for_current_month.should eql(90.0)
    
    Expense.stub!(:total_for_current_month).and_return(-900)
    Expense.average_for_current_month.should eql(-90.0)
  end  
  
  
  it "should calculate correctly the amount of bancomat expenses" do
    Expense.total_for_bancomat_in_month(Date.new(2009, 2, 1)).should eql(10.0)
    Expense.total_for_bancomat_in_month(Date.new(2009, 3, 1)).should eql(0.0)
  end
  
  it "should calculate correctly a monthly prevision" do
    Date.stub!(:today).and_return(Date.new(2009,1,1))
    
    Expense.prevision_for_current_month.should eql(0.0)
    
    Expense.stub!(:total_for_current_month).and_return(-10)
    Expense.prevision_for_current_month.should eql(-310.0)
    
    # One day left: prevision = current total + daily average
    Date.stub!(:today).and_return(Date.new(2009,1,30))  
    Expense.stub!(:total_for_current_month).and_return(-300)
    Expense.prevision_for_current_month.should eql(-310.0)
    
    Expense.stub!(:total_for_current_month).and_return(0)
    Expense.prevision_for_current_month.should eql(0.0)
  end

  it "should calculate how much money is left for the current month" do
    Date.stub!(:today).and_return(Date.new(2009,1,1))
    Expense.left_for_current_month_with_stipendio(1190).should eql(1190.0)
  	Expense.create!(:description => "Third", :amount => -400, :date => Date.new(2009,1,1),
  	        :category => @altro, :account => @contanti)
    
    Expense.left_for_current_month_with_stipendio(1200).should eql(800.0)    
  	
  	Expense.create!(:description => "Stipendio", :amount => 1200, :date => Date.new(2009,1,1),
  	        :category => @stipendio, :account => @contanti)
  
    Expense.left_for_current_month_with_stipendio(1200).should eql(800.0)   
  end
  
  it "should have category" do
    category = Category.create!(:name => "Category one")
    Expense.new(:description => "Third", :amount => -400, :date => Date.new(2009,1,1),
  	        :category => category, :account => Account.bancomat).should be_valid
  end
  
  it "should have account" do
    category = Category.create!(:name => "Category one")
    account = Account.create!(:name => "Contanti")
    Expense.new(:description => "Third", :amount => -400, :date => Date.new(2009,1,1),
  	        :category => category, :account => account).should be_valid  
  end

  it "should retrieve expenses by category, year and month" do
    e4 = Expense.create!(:description => "Fourth", :amount => 1000, :date => Date.new(2009,1,1), :category => @stipendio, :account => @bancomat)
    amounts = Expense.amounts_for_categories(Date.new(2009, 1, 1))
    amounts["Stipendio"].should eql(1000.0)
  end
  
  it "should generate a correct google chart with only negative values" do
    Expense.stub!(:amounts_for_categories).and_return(
    {"Cibo" => -100,
      "Benza" => -15,
      "Elettronica" => 200
    })
    
    expected_url = "http://chart.apis.google.com/chart?cht=p&chd=t:15,100&chs=350x150&chl=Benza|Cibo&chco=FF0000"
    
    
    assert_equal expected_url, Expense.generate_google_chart(Date.new(2009, 1, 1))
      end

end
