require 'spec_helper'

include Expense::Charts

describe Expense::Charts do
  
  it "fetches daily labels for chart" do
    Date.stub!(:today).and_return(Date.new(2009, 11, 1))
    labels = daily_labels_for_month_of(Date.today)
    labels.split("|").should have(30).labels
    labels.split("|").first.should eql("1")
    labels.split("|").last.should eql("30")
  end
  
end