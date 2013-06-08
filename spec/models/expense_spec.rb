require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Expense do

  it "should belong to an user" do
    user = Factory(:user)
    expense = Factory(:expense, :user => user)
    expense.user.should == user
  end
  
end
