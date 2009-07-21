require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fastercsv'

describe ExpenseCsvImporter do

  fixtures_path = RAILS_ROOT + "/spec/fixtures/expenses.csv"

  before(:each) do
    Expense.delete_all
  end
  
  it "should load a csv file" do
    csv = File.open(fixtures_path)
    lines = 0
    csv.each { |l| lines += 1; }
    lines.should eql(40)
    csv.close
  end
  
  it "should parse a line from the csv file" do
    Expense.count.should eql(0)
    csv_line = File.open(fixtures_path).readline
    importer = ExpenseCsvImporter.new(fixtures_path)
    importer.import_line csv_line
    Expense.count.should eql(1)
  end
  
  it "should parse all the lines from the csv file" do
    Expense.count.should eql(0)
    importer = ExpenseCsvImporter.new fixtures_path
    importer.import
    Expense.count.should eql(40)
  end

end
