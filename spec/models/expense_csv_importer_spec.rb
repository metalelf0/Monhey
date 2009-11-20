require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fastercsv'

describe ExpenseCsvImporter do

  fixtures_path = RAILS_ROOT + "/spec/fixtures/expenses.csv"

  it "should parse a line from the csv file" do
    importer = ExpenseCsvImporter.new("a path")
    csv_line = "2009-06-21,-15,Pranzo terme primia,Cibo"
    category = mock("Category")
    Category.should_receive(:find_or_create_by_name).with("Cibo").and_return(category)
    Expense.should_receive(:create).with(:date => "2009-06-21", :amount => "-15",
      :description => "Pranzo terme primia", :category => category)
    importer.import_line csv_line
  end
  
  it "should parse all the lines from the csv file" do

    importer = ExpenseCsvImporter.new fixtures_path
    Category.should_receive(:find_or_create_by_name).exactly(40).times
    Expense.should_receive(:create).exactly(40).times
    importer.import

  end

end
