require 'spec_helper'

describe ExpenseRepository do

  ### November 2013
  ### 
  ### Monday          4 11 18 *25
  ### Tuesday         5 12 19  26
  ### Wednesday       6 13 20  27
  ### Thursday        7 14 21  28
  ### Friday       1  8 15 22  29
  ### Saturday     2  9 16 23  30
  ### Sunday       3 10 17 24

  let!(:john) { Factory(:user, email: "john.doe@email.com") }
  let!(:food) { Factory(:category, :user => john, :name => "Food") }
  let!(:expense_to_be_ignored) { Factory(:expense, :user => john, :date => Date.new(2013, 11, 1), :amount => -100, :category => food) }
  let!(:valid_expense) { Factory(:expense, :user => john, :date => Date.new(2013, 11, 12), :amount => -130, :category => food) }

  it "correctly retrieves expenses for a given month divided by week" do
    john.expenses_by_year_and_month_weekly(:date => Date.new(2013, 11, 1)).should == {
      45 => [ valid_expense ]
    }
  end

end
