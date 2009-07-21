require 'consoleLibs.rb'

describe Object do
  
  validArguments = {
    DESCRIPTION => "Sample expense",
    AMOUNT => "-9.90",
    CATEGORY => "Altro",
    DATE => "2009/07/01"
  }
  
  validArguments2 = {
    DESCRIPTION => "Another sample expense",
    AMOUNT => "-9.90",
    CATEGORY => "Altro",
    DATE => "2009/06/01"
  }

  validArguments3 = {
    DESCRIPTION => "Third sample expense",
    AMOUNT => "-9.90",
    CATEGORY => "Altro",
    DATE => "2009/05/01"
  }
  
  before :each do
    if (ENV["RAILS_ENV"] != "test")
      puts "Che fai? Non sei in test!"
      exit -1
    end
    Expense.all.each do |exp|
      exp.destroy
    end
  end

  it "should pad and trim strings correctly" do
    sample = "string"
    (sample.pad_to 10).size.should eql(10)
    (sample.pad_to 10).should eql("string    ")
    sample = "aMuchLongerString"
    (sample.pad_to 10).size.should eql(10)
    (sample.pad_to 10).should eql("aMuchLonge")
  end

  it "should create an expense correctly" do
    expense = buildExpenseFromParams validArguments
    expense.description.should eql("Sample expense")
    expense.amount.should eql(-9.90)
    expense.category.should eql("Altro")
  end
  
  it "should not save a not valid expense" do
    before = Expense.all.size
    arguments = {
      DESCRIPTION => "Sample expense",
      AMOUNT => "Barking dog"
    }
    expense = buildAndSaveExpenseFromParams arguments
    expense.errors["amount"].should include("is not a number")
    expense.errors["category"].should include("can't be blank")
    arguments[CATEGORY] = "A non existing category"
    expense = buildAndSaveExpenseFromParams arguments
    expense.errors["category"].should include("is not a valid category")
    Expense.all.size.should eql(before)  
  end
  
  it "should save an expense correctly" do
    before = Expense.count
    expense = buildAndSaveExpenseFromParams validArguments
    expense.description.should eql("Sample expense")
    expense.amount.should eql(-9.90)
    Expense.count.should eql(before + 1)
  end
  
  it "should delete an expense correctly" do
    before = Expense.all.size
    expense = buildAndSaveExpenseFromParams validArguments    
    Expense.count.should eql(before + 1)
    # Here I delete the first expense, even if this could not be the expense
    # i saved before
    deleteExpense "0"
    Expense.count.should eql(before)
  end

  # it "should show the right entries in list mode" do
  #     buildAndSaveExpenseFromParams validArguments
  #     buildAndSaveExpenseFromParams validArguments2
  #     buildAndSaveExpenseFromParams validArguments3
  #     Expense.all.size.should eql(3)
  #     Expense.view_reduce(Expense.database_name, "by_date_arr", :include_docs => true, :startkey => [2009, 5], :endkey => [2009, 6], :reduce => false).should have(1).element
  #     Expense.view_reduce(Expense.database_name, "by_date_arr", :include_docs => true, :startkey => [2009, 6], :endkey => [2009, 7], :reduce => false).should have(1).element
  #     Expense.view_reduce(Expense.database_name, "by_date_arr", :include_docs => true, :startkey => [2009, 7], :endkey => [2009, 8], :reduce => false).should have(1).element
  #     expensesIn(2009, 5).should have(1).expense
  #     expensesIn(2009, 6).should have(1).expense
  #     expensesIn(2009, 7).should have(1).expense
  #     expensesFromTo(2009, 5, 2009, 7).should have(3).expenses
  #   end
  
end