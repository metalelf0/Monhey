require 'spec_helper'

describe Category do

  it "should belong to an user" do
    user = Factory(:user)
    category = Factory(:category, :user => user)
    category.user.should == user
  end

  it "should be able to calculate monthly totals" do
    user = Factory(:user)
    cat = Factory.build(:category, :user => user)
    user.should_receive(:total_for_month_by_category).exactly(12).times
    cat.totals_for_year(2009)
  end

  it "should get a correct monthly total string for a given year" do
    ExpenseRepository.any_instance.should_receive(:total_for_month_by_category).exactly(12).times.and_return(-10.0)
    cat = Factory.build(:category)
    expected_labels = ([-10.0] * 12).join(',')
    expected = "http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:" + expected_labels + "&chxl=0:|" + Category::MONTHS + "|1:|0|250|500|750|1000&chs=500x150&chds=0,1000"

    cat.google_chart_for_year(2009).should eql(expected)
  end


end
