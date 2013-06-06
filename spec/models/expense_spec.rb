require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Expense do
  
  #         Aprile 2013           Maggio 2013           Giugno 2013
  #  Do Lu Ma Me Gi Ve Sa  Do Lu Ma Me Gi Ve Sa  Do Lu Ma Me Gi Ve Sa
  #      1  2  3  4  5  6            1  2  3  4                     1
  #   7  8  9 10 11 12 13   5  6  7  8  9 10 11   2  3  4  5  6  7  8
  #  14 15 16 17 18 19 20  12 13 14_15_ 16 17 18   9 10 11 12 13 14 15
  #  21 22 23 24 25 26 27  19 20 21 22 23 24 25  16 17 18 19 20 21 22
  #  28 29 30              26 27 28 29 30 31     23 24 25 26 27 28 29
  #                                              30
  #  
  let!(:today) { Date.new(2013, 5, 15) }
  let!(:first_category) { Factory(:category, :name => "First category")}
  let!(:second_category) { Factory(:category, :name => "Second category")}
  let!(:third_category) { Factory(:category, :name => "Incomes category")}
  let!(:expense_today) { Factory(:expense, :amount => -10.0, :category => first_category, :date => today) }
  let!(:expense_yesterday) { Factory(:expense, :amount => -20.0, :category => second_category, :date => today - 1) }
  let!(:income_yesterday) { Factory(:expense, :amount =>  5.0, :category => third_category, :date => today - 1) }
  let!(:expense_one_month_ago) {Factory(:expense, :amount => -30.0, :date => today - 1.month) }

  it "should belong to an user" do
    user = Factory(:user)
    expense = Factory(:expense, :user => user)
    expense.user.should == user
  end

  it "should retrieve monthly categories report" do
    report = Expense.monthly_categories_report(today)
    report["First category"].should == -10
    report["Second category"].should == -20
  end
  
  it "should get the right per-day amount" do
    Expense.total_for_day(today).should == -10
  end

  it "should generate a correct google chart with only negative values" do
    expected_url = 'http://chart.apis.google.com/chart?cht=p&chd=t:10,20&chs=350x150&chl=First%20category%7CSecond%20category&chco=FF0000'
    Expense.generate_expenses_pie_chart(today).should eql(expected_url)
  end

  
end
