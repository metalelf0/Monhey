require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Creating an entry" do

  before :each do
    Expense.delete_all
    Category.delete_all
    Account.delete_all
    Account.create(:name => 'Contanti')
    Account.create(:name => 'Bancomat')
    Category.create(:name => 'Cibo')
    Category.create(:name => 'Altro')
    Category.create(:name => 'Elettronica')    
  end

  it "should save an entry through the first insert fields-row" do
    Expense.count.should eql(0)
    visit 'expenses'

    fill_in "elem1[amount]", :with => "-10"
    fill_in "elem1[description]", :with => "Spesa di prova"

    select "Altro", :from => "elem1_category_id"

    click_button "Save"
    Expense.count.should eql(1)
    expense = Expense.first
    expense.description.should eql("Spesa di prova") 
    expense.amount.should eql(-10.0)
    expense.date.should eql(Date.today)
  end

  it "should save more than one entry through edit fields-rows" do
    Expense.count.should eql(0)
    visit 'expenses'

    fill_in "elem1[amount]", :with => -10
    fill_in "elem1[description]", :with => "Spesa di prova n. 1"
    select "Altro", :from => "elem1_category_id"

    fill_in "elem2[amount]", :with => -15
    fill_in "elem2[description]", :with => "Spesa di prova n. 2"
    select "Elettronica", :from => "elem2_category_id"

    fill_in "elem3[amount]", :with => -20
    fill_in "elem3[description]", :with => "Spesa di prova n. 3"
    select "Cibo", :from => "elem3_category_id"


    click_button "Save"
    Expense.count.should eql(3)  
  end

  
end
