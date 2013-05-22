require 'spec_helper'

describe "User and expenses integration" do
  
  it "correctly associates user and expenses via a Repo" do
    john = Factory(:user, email: "john.doe@email.com")
    sam  = Factory(:user, email: "sam.dunn@email.com")
    
    john_expense = Factory(:expense, :user => john)
    sam_expense = Factory(:expense, :user => sam)
    
    john.repository.expenses.should == [ john_expense ]  
  end
  
end