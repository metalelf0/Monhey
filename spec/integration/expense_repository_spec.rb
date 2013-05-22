require 'spec_helper'

describe ExpenseRepository do

  let!(:john)           { Factory(:user, email: "john.doe@email.com") }
  let!(:sam)            { Factory(:user, email: "sam.dunn@email.com") }
  let!(:john_expense)   { Factory(:expense, :user => john, :date => Date.new(2012, 1, 10)) }
  let!(:sam_expense)    { Factory(:expense, :user => sam)  }
  
  it "correctly associates user and expenses via a Repo" do    
    john.expenses.should == [ john_expense ]  
  end
  
  it "searches expenses by year and month" do
    john.expenses_by_year_and_month(:date => Date.new(2012, 1, 1)).should == [ john_expense ]
  end
  
end