require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Creating an entry" do

  it "should save an entry through the first insert fields-row" do
    Expense.count.should eql(0)
    visit 'expenses'

    fill_in "elem1[amount]", :with => -10
    fill_in "elem1[buoni]", :with => 1
    fill_in "elem1[description]", :with => "Spesa di prova"
    select "Altro", :from => "elem1_category"

    click_button "Save"
    Expense.count.should eql(1)
    Expense.first.description.should eql("Spesa di prova") 
    Expense.first.amount.should eql(-10.0)
    Expense.first.date.should eql(Date.today)
  end

  it "should save more than one entry through edit fields-rows" do
    Expense.count.should eql(0)
    visit 'expenses'

    fill_in "elem1[amount]", :with => -10
    fill_in "elem1[buoni]", :with => 1
    fill_in "elem1[description]", :with => "Spesa di prova n. 1"
    select "Altro", :from => "elem1_category"

    fill_in "elem2[amount]", :with => -15
    fill_in "elem2[buoni]", :with => 0
    fill_in "elem2[description]", :with => "Spesa di prova n. 2"
    select "Elettronica", :from => "elem2_category"

    fill_in "elem3[amount]", :with => -20
    fill_in "elem3[buoni]", :with => 2
    fill_in "elem3[description]", :with => "Spesa di prova n. 3"
    select "Cibo", :from => "elem3_category"


    click_button "Save"
    Expense.count.should eql(3)  
  end

  
end
