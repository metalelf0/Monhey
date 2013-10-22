require 'spec_helper'

describe RecurringExpense do

  let(:user) { Factory(:user) }
  let(:category) { Factory(:category, :user => user) }


  describe 'setup recurring expenses' do

    it "allows adding yearly expenses"
    it "allows adding weekly expenses"

    describe "setups monthly expenses for an year" do

      before do
        Date.stub(:today).and_return(Date.new(2013, 1, 10))
      end

      let(:recurring_expense) {
        described_class.new(
          user: user,
          amount: 1000,
          description: 'wage',
          start_date: Date.today,
          end_date: (Date.today + 1.year).beginning_of_month,
          category_id: category.id
        )
      }

      it "creates expenses" do
        Expense.count.should be_zero
        recurring_expense.create_items
        Expense.count.should == 12 # 12 for the year
        Expense.pluck(:date).map(&:day).uniq.should == [ 1 ]
      end

      it "allows choosing the date of month for monthly expenses" do
        recurring_expense.day_of_month = 15
        recurring_expense.end_date = Date.new(Date.today.year, Date.today.month, 16) + 1.year
        recurring_expense.create_items
        Expense.count.should == 13 # 1 for current month + 12 for the year
        Expense.pluck(:date).map(&:day).uniq.should == [ 15 ]
      end

      it "allows choosing a different start date" do
        recurring_expense.start_date = Date.today.beginning_of_month + 6.months
        recurring_expense.end_date = Date.today.end_of_month + 6.months
        recurring_expense.day_of_month = 15
        recurring_expense.create_items
        Expense.count.should == 1 # 1 for current month + 12 for the year
        Expense.pluck(:date).map(&:day).uniq.should == [ 15 ]
      end
    end

  end
end
