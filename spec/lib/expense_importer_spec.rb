require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fastercsv'

describe ExpenseImporter do

  fixtures_path = RAILS_ROOT + "/spec/fixtures/expenses.csv"
  fixtures_path_easymoney = RAILS_ROOT + "/spec/fixtures/expenses_easymoney.csv"
  fixtures_path_cartasi = RAILS_ROOT + "/spec/fixtures/movimenti_cartasi.txt"

  it "should parse a line from the csv file" do
    importer = ExpenseImporter.new("a path")
    parsed_row = ["2009-06-21","-15","Pranzo terme primia","Cibo"]
    category = mock_model(Category)
    Category.should_receive(:find_or_create_by_name).with("Cibo").and_return(category)
    Date.should_receive(:parse).with("2009-06-21").and_return(:some_date)
    Expense.should_receive(:create).with(:date => :some_date, :amount => "-15",
      :description => "Pranzo terme primia", :category => category)
    importer.import_row parsed_row
  end
 
  it "should parse a line from the easymoney csv file" do
    importer = ExpenseImporter.new("a path", :easymoney)
    parsed_row = ["Benza", "Transportation", "-60.68", "Uncleared", "15 Mar 2010"]
    category = mock_model(Category)
    Date.should_receive(:parse).with("15 Mar 2010").and_return(:some_date)
    Category.should_receive(:find_or_create_by_name).with("Transportation").and_return(category)
    Expense.should_receive(:create).with(:date => :some_date, :amount => "-60.68",
      :description => "Benza", :category => category)
    importer.import_row parsed_row
  end
  
  
  it "should parse all the lines from the csv file" do
    importer = ExpenseImporter.new fixtures_path
    Category.should_receive(:find_or_create_by_name).exactly(40).times
    Expense.should_receive(:create).exactly(40).times
    importer.import
  end

  it "should parse all the lines from the easymoney csv file" do
    importer = ExpenseImporter.new fixtures_path_easymoney, :easymoney
    Category.should_receive(:find_or_create_by_name).exactly(8).times
    Expense.should_receive(:create).exactly(8).times
    importer.import
  end

  it "should parse all lines from a cartasi report" do
    importer = ExpenseImporter.new fixtures_path_cartasi, :cartasi
    Category.should_receive(:find_or_create_by_name).exactly(5).times
    Expense.should_receive(:create).exactly(5).times
    importer.import
  end

  it "should swap month and year when importing an expense from a cartasi report"

  it "should log exceptions somewhere better than STDOUT"

end
