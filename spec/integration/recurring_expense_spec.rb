require 'spec_helper'

describe RecurringExpense do

  let(:user) { Factory(:user) }
  let(:category) { Factory(:category, :user => user) }
  let(:recurring_expense) {
    described_class.new(
      user: user,
      amount: 1000,
      description: 'wage',
      end_date: (Date.today + 1.year).beginning_of_month,
      category_id: category.id
    )
  }


  describe 'setup recurring expenses' do

    it "allows adding yearly expenses"
    it "allows adding weekly expenses"
    it "allows choosing the date of month for monthly expenses"

    it "setups monthly expenses for an year" do
      Expense.count.should be_zero
      recurring_expense.create_items
      Expense.count.should == 13 # 1 for current month + 12 for the year
      Expense.pluck(:date).map(&:day).uniq.should == [ 1 ] 
    end

  end
end
