require 'spec_helper'

describe ExpenseRepository do

  let!(:john)                   { Factory(:user, email: "john.doe@email.com") }
  let!(:sam)                    { Factory(:user, email: "sam.dunn@email.com") }
  let!(:john_food)              { Factory(:category, :user => john, :name => "Food") }
  let!(:sam_food)               { Factory(:category, :user => sam, :name => "Food") }
  let!(:john_travel)            { Factory(:category, :user => john, :name => "Travel") }
  let!(:john_expense)           { Factory(:expense, 
                                    :user => john, 
                                    :date => Date.new(2012, 1, 10),
                                    :amount => -10.0,
                                    :category => john_food
                                  ) 
                                }

  let!(:another_john_expense)   { Factory(:expense, 
                                    :user => john, 
                                    :date => Date.new(2012, 1, 10),
                                    :amount => -10.0,
                                    :category => john_travel
                                  ) 
                                }                                

  let!(:sam_expense)            { Factory(:expense, :user => sam)  }
  
  it "correctly associates user and expenses via a Repo" do    
    john.expenses.should == [ john_expense, another_john_expense ]  
  end
  
  it "searches expenses by year and month" do
    john.expenses_by_year_and_month(:date => Date.new(2012, 1, 1)).should == [ john_expense, another_john_expense ]
  end

  it "calculates how much money is left for a given month" do
    john.left_for_month(:date => Date.new(2012, 1, 1), :wage => 2000).should == 2000 + -10 + -10
  end

  it "searches expenses by year, month, and category" do
    john.expenses_by_year_month_and_category(:date => Date.new(2012, 1, 1), :category_name => "Food").should == [ john_expense ]
  end
  
  it "calculates total for a given month" do
    john.total_for_month(:date => Date.new(2012, 1, 1)).should == -20.0
  end
  
  it "calculates daily average for a given month" do
    john.daily_average_for_month(:date => Date.new(2012, 1, 1)).should == (-20.0 / 31)
  end
  
  context "Calculating monthly prevision" do

    context "when current month" do

      it "returns the current average multiplied the number of days in current month" do
        average = john.daily_average_for_month(:date => Date.today)
        john.prevision_for_month(:date => Date.today).should == average * 31
      end
      
      it "can also include wage" do
        average = john.daily_average_for_month(:date => Date.today)
        john.prevision_for_month(:date => Date.today, :wage => 1000).should == 1000 + average * 31
      end
          
    end
  
  end  

  context "Daily total" do

    it "gets the right per-day amount" do
      john.total_for_day(:date => Date.new(2012, 1, 10)).should == -20
    end

  end

  
end
