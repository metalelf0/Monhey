require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  
  it "should be able to calculate monthly totals" do
    Expense.should_receive(:total_for_month_by_category).exactly(12).times
    cat = Factory.build(:category)
    cat.totals_for_year(2009)
  end
  
  
end