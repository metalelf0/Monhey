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
  
  it "should get the same value for total for month with two dates in the same month" do
    Expense.total_for_month(Date.new(2009, 2, 1)).should eql(10.0)
    Expense.total_for_month(Date.new(2009, 2, 28)).should eql(10.0)
  
    Date.stub!(:today).and_return(Date.new(2009, 2, 15))
  
    Expense.total_for_month(Date.today).should eql(10.0)
    Expense.total_for_month(Date.new(2009, 2, 1)).should eql(10.0)
    Expense.total_for_month(Date.new(2009, 2, 28)).should eql(10.0)  
  end
  
  it "should calculate correctly the average value for the current month" do
    Date.stub!(:today).and_return(Date.new(2009,1,1))
    Expense.average_for_month(Date.new(2009,1,1)).should eql(0.0)
    
    Date.stub!(:today).and_return(Date.new(2009,1,10))
    Expense.stub!(:total_for_month).and_return(900)
    Expense.average_for_month(Date.new(2009,1,1)).should eql(90.0)
    
    Expense.stub!(:total_for_month).and_return(-900)
    Expense.average_for_month(Date.new(2009,1,1)).should eql(-90.0)
  end  
  
  
  it "should calculate correctly the amount of bancomat expenses" do
    Expense.total_for_bancomat_in_month(Date.new(2009, 2, 1)).should eql(10.0)
    Expense.total_for_bancomat_in_month(Date.new(2009, 3, 1)).should eql(0.0)
  end
  
  it "should calculate correctly a monthly prevision" do
    Date.stub!(:today).and_return(Date.new(2009,1,1))
    
    Expense.prevision_for_month(Date.today).should eql(0.0)
    
    Expense.stub!(:total_for_month).and_return(-10)
    Expense.prevision_for_month(Date.today).should eql(-310.0)
    
    # One day left: prevision = current total + daily average
    Date.stub!(:today).and_return(Date.new(2009,1,30))  
    Expense.stub!(:total_for_month).and_return(-300)
    Expense.prevision_for_month(Date.today).should eql(-310.0)
    
    Expense.stub!(:total_for_month).and_return(0)
    Expense.prevision_for_month(Date.today).should eql(0.0)
  end

  it "should calculate how much money is left for the current month" do
    Date.stub!(:today).and_return(Date.new(2009,1,1))
    Expense.left_for_month_with_stipendio(Date.today, 1190).should eql(1190.0)
  	Expense.create!(:description => "Third", :amount => -400, :date => Date.new(2009,1,1),
  	        :category => @altro, :account => @contanti)
    
    Expense.left_for_month_with_stipendio(Date.today, 1200).should eql(800.0)    
  	
  	Expense.create!(:description => "Stipendio", :amount => 1200, :date => Date.new(2009,1,1),
  	        :category => @stipendio, :account => @contanti)
  
    Expense.left_for_month_with_stipendio(Date.today, 1200).should eql(800.0)   
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
  
  it "should get the right per-day amount" do
    date = Date.new(2009,1,30)
    one = mock(:amount => 10.0, :date => date)
    Expense.should_receive(:find_all_by_date).with(date).and_return( [one] )
    Expense.total_for_day(date).should eql(10.0)
    
    two = mock(:amount => -5.0, :date => date)
    Expense.should_receive(:find_all_by_date).with(date).and_return( [one, two] )
    Expense.total_for_day(date).should eql(5.0)
  end
  
  it "should generate a correct google chart with only negative values" do
    Expense.stub!(:amounts_for_categories).and_return(
    {"Cibo" => -100,
      "Benza" => -15,
      "Elettronica" => 200
    })
    
    expected_url = "http://chart.apis.google.com/chart?cht=p&chd=t:15,100&chs=350x150&chl=Benza|Cibo&chco=FF0000"
    Expense.generate_expenses_pie_chart(Date.new(2009, 1, 1)).should eql(expected_url)
  end
  
  it "should get a correct daily expenses string for an expense-empty month" do
    Date.stub!(:today).and_return(Date.new(2009, 11, 30)) # thirty days month...
    expected_string = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" # ...thirty zeros
    Expense.amounts_by_date_for_month(Date.today).should eql(expected_string)
  end
  
  it "should get a correct daily expenses string for a month with expenses" do
    Date.stub!(:today).and_return(Date.new(2009, 11, 30))
    first = Date.new(2009, 11, 1)
    last = Date.new(2009, 11, 30)
    Expense.stub!(:total_for_day).and_return(0)
    Expense.should_receive(:total_for_day).with(first).and_return(10)
    Expense.should_receive(:total_for_day).with(last).and_return(5)
    
    expected_string = "10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5"
    Expense.amounts_by_date_for_month(Date.today).should eql(expected_string)
  end
  
  it "should invert expense amounts on the daily expenses chart" do
    Date.stub!(:today).and_return(Date.new(2009, 11, 30))
    first = Date.new(2009, 11, 1)
    last = Date.new(2009, 11, 30)
    Expense.stub!(:total_for_day).and_return(0)
    Expense.should_receive(:total_for_day).with(first).and_return(-10.0)
    Expense.should_receive(:total_for_day).with(last).and_return(-5.0)
    actual_url = Expense.generate_daily_chart_for(Date.today)
    expected_string = "10.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5.0"
    expected_url = "http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:" + expected_string + "&chxl=0:|" + labels_for(Date.today) + "|1:|0|250|500|750|1000&chs=500x150&chds=0,1000"
    actual_url.should eql(expected_url)
  end

  it "should calculate the right font size in tag cloud" do
    total, lowest, highest = 0, 0, 0
    Expense.font_size_for_tag_cloud(total, lowest, highest).should eql("display:none;")
  
    total, lowest, highest = 0, -10, 10
    Expense.font_size_for_tag_cloud(total, lowest, highest).should eql("display:none;")
  
    # total == lowest means highest expense!
    total, lowest, highest = 10, -10, 10
    Expense.font_size_for_tag_cloud(total, lowest, highest).should eql("font-size:12px;")

    # total == highest means lowest expense!  
    total, lowest, highest = -10, -10, 10
    Expense.font_size_for_tag_cloud(total, lowest, highest).should eql("font-size:32px;")
    
    # don't panic if highest is zero
    total, lowest, highest = -10, -10, 0
    Expense.font_size_for_tag_cloud(total, lowest, highest).should eql("font-size:32px;")
    
    #don't panic if they're all the same
    total, lowest, highest = -10, -10, -10
    Expense.font_size_for_tag_cloud(total, lowest, highest).should eql("font-size:32px;")
    
  end
  
  it "should generate correctly the hash for categories cloud" do
    amounts = { "Cibo" => -10, "Altro" => -20}
    Expense.stub!(:amounts_for_categories).and_return amounts
    hash = Expense.generate_hash_for_categories_cloud(Date.today)
    hash["Altro"][:style].should eql("font-size:32px;")
    hash["Altro"][:amount].should eql(-20)
    hash["Cibo"][:style].should  eql("font-size:12px;")
    hash["Cibo"][:amount].should  eql(-10)
  end

end
