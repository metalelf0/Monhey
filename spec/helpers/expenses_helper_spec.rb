require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesHelper do
  
  it "should retrieve correctly start date and end date for a month" do
    start_date, end_date = start_and_end_of_month(2009, 2)
    start_date.should eql(Date.new(2009, 2, 1))
    end_date.should eql(Date.new(2009, 2, 28))
  end

end
