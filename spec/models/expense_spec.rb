require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Expense do

  it "should retrieve expenses in a given month" do
    Expense.should_receive(:find).and_return([@e1])
  	expenses_of_february = Expense.find_by_year_month(:date => Date.new(2009, 2, 1))
  	expenses_of_february.size.should eql(1)
  end
  
  it "should calculate correctly the average value for the current month" do
    date = mock("date")
    today = mock("today")
    date.should_receive(:is_in_current_month).and_return(true)
    Date.should_receive(:today).and_return(today)
    today.should_receive(:day).and_return(10)
    Expense.should_receive(:total_for_month).with(date).and_return(-100.0)
    Expense.average_for_month(date).should eql(-10.0)
  end
  
  it "should calculate correctly the average value for the another month" do
    date = mock("date")
    some_day = mock("today")
    date.should_receive(:is_in_current_month).and_return(false)
    date.should_receive(:end_of_month).and_return(some_day)
    some_day.should_receive(:day).and_return(31)
    Expense.should_receive(:total_for_month).with(date).and_return(-310.0)
    Expense.average_for_month(date).should eql(-10.0)
  end
    
  it "should calculate correctly a monthly prevision - current month" do
    date = mock("date")
    some_day = mock("some_day")
    date.should_receive(:is_in_current_month).and_return(true)
    Expense.should_receive(:average_for_month).with(date).and_return(-10.0)
    date.should_receive(:end_of_month).and_return(some_day)
    some_day.should_receive(:day).and_return(31)
    Expense.prevision_for_month(date).should eql(-310.0)
  end

  it "should calculate correctly a monthly prevision - another month" do
    date = mock("date")
    date.should_receive(:is_in_current_month).and_return(false)
    Expense.should_receive(:total_for_month).with(date).and_return(-100.0)
    Expense.prevision_for_month(date).should eql(-100.0)
  end

  it "should calculate how much money is left for the current month" do
    date = mock("date")
    date.should_receive(:is_in_current_month).and_return(true)
    Expense.should_receive(:sum).and_return(-150.0)
    Expense.left_for_month_with_stipendio(date, 100).should eql(-50.0)   
  end
  
  it "should calculate how much money is left for a future month - eql stipendio" do
    date = mock("date")
    date.should_receive(:is_in_current_month).and_return(false)
    date.should_receive(">").with(Date.today).and_return(true)
    Expense.left_for_month_with_stipendio(date, 100).should eql(100.0) 
  end

  it "should calculate how much money is left for an old month" do
    date = mock("date")
    date.should_receive(:is_in_current_month).and_return(false)
    date.should_receive(">").with(Date.today).and_return(false)
    Expense.should_receive(:total_for_month).with(date).and_return(-100.0)
    Expense.left_for_month_with_stipendio(date, 1000).should eql(900.0) 
  end
  
  it "should retrieve expenses by category, year and month" do
    date = mock("date")
    category = Category.new(:name => "category")
    Category.should_receive(:all).and_return([category])

    Expense.should_receive(:total_for_month_by_category).with(date, category.name).and_return -1000.0
    amounts = Expense.amounts_for_categories(date)
    amounts["category"].should eql(-1000.0)
  end
  
  it "should get the right per-day amount" do
    date = Date.new(2009,1,30)
    one = mock(:amount => -10.0, :date => date)
    Expense.should_receive(:find_all_by_date).with(date).and_return( [one] )
    Expense.total_for_day(date).should eql(-10.0)
    
    two = mock(:amount => -5.0, :date => date)
    Expense.should_receive(:find_all_by_date).with(date).and_return( [one, two] )
    Expense.total_for_day(date).should eql(-15.0)
  end
  
  it "should generate a correct google chart with only negative values" do
    Expense.stub!(:amounts_for_categories).and_return(
    {"Cibo" => -100,
      "Benza" => -15,
      "Mance" => 200
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
    
    expected_string = "-10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-5"
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
    expected_url = "http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:" + expected_string + "&chxl=0:|" + daily_labels_for_month_of(Date.today) + "|1:|0|250|500|750|1000&chs=500x150&chds=0,1000"
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
