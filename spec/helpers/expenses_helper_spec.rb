require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesHelper do
  
  it "should retrieve correctly start date and end date for a month" do
    start_date, end_date = start_and_end_of_month(Date.new(2009, 2, 1))
    start_date.should eql(Date.new(2009, 2, 1))
    end_date.should eql(Date.new(2009, 2, 28))
  end

  it "should get the labels for a month" do
    Date.stub!(:today).and_return(Date.new(2009, 11, 1))
    labels = daily_labels_for_month_of(Date.today)
    labels.split("|").should have(30).labels
    labels.split("|").first.should eql("1")
    labels.split("|").last.should eql("30")
  end

end
