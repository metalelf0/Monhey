require 'spec_helper'

describe Account do
  
  it "belongs to user" do
    user = Factory(:user)
    account = Factory(:account, :user => user)
    account.user.should == user
  end
  
  it "deletes associated expenses on delete" do
    account = Factory(:account)
    expense = Factory(:expense, :account => account)
    account.destroy
    Expense.count.should == 0
  end
end