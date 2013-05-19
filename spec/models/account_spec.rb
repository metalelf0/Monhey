require 'spec_helper'

describe Account do
  
  it "deletes associated expenses on delete" do
    account = Factory(:account)
    expense = Factory(:expense, :account => account)
    account.destroy
    Expense.count.should == 0
  end
end