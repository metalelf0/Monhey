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

    set_hidden_field "elem1[sign]", :to => "-"
    fill_in "elem1[amount]", :with => "10"
    fill_in "elem1[description]", :with => "Spesa di prova"
    fill_in "elem1[category_name]", :with => "Altro"


    click_button "Save"
    Expense.count.should eql(1)
    expense = Expense.first
    expense.description.should eql("Spesa di prova") 
    expense.amount.should eql(-10.0)
    expense.date.should eql(Date.today)
    expense.category.name.should == "Altro"
  end

  it "should save more than one entry through edit fields-rows" do
    Expense.count.should eql(0)
    visit 'expenses'

    fill_in "elem1[amount]", :with => 10
    fill_in "elem1[description]", :with => "Spesa di prova n. 1"
    fill_in "elem1[category_name]", :with => "Altro"

    fill_in "elem2[amount]", :with => 15
    fill_in "elem2[description]", :with => "Spesa di prova n. 2"
    fill_in "elem2[category_name]", :with => "Elettronica"

    fill_in "elem3[amount]", :with => 20
    fill_in "elem3[description]", :with => "Spesa di prova n. 3"
    fill_in "elem3[category_name]", :with => "Cibo"


    click_button "Save"
    Expense.count.should eql(3)  
  end

  
end
