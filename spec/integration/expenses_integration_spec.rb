require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Creating an entry" do

  before :each do
    Expense.delete_all
    Category.delete_all
    user = Factory(:user)
    Factory(:category, :user => user, :name => 'Cibo')
    Factory(:category, :user => user, :name => 'Altro')
    Factory(:category, :user => user, :name => 'Elettronica')
  end

  it "should save an entry through the first insert fields-row" do
    login_with_oauth
    Expense.count.should eql(0)
    visit 'expenses'

    set_hidden_field "elem1[sign]", :to => "-"
    fill_in "elem1[amount]", :with => "10"
    fill_in "elem1[description]", :with => "Spesa di prova"
    select "Altro", :from => "elem1[category_id]"

    click_button "Save"
    Expense.count.should eql(1)
    expense = Expense.first
    expense.description.should eql("Spesa di prova") 
    expense.amount.should eql(-10.0)
    expense.date.should eql(Date.today)
    expense.category.name.should == "Altro"
  end

  it "should save more than one entry through edit fields-rows" do
    login_with_oauth
    Expense.count.should eql(0)
    visit 'expenses'

    fill_in "elem1[amount]", :with => 10
    fill_in "elem1[description]", :with => "Spesa di prova n. 1"
    select "Altro", :from => "elem1[category_id]"

    fill_in "elem2[amount]", :with => 15
    fill_in "elem2[description]", :with => "Spesa di prova n. 2"
    select "Elettronica", :from => "elem2[category_id]"

    fill_in "elem3[amount]", :with => 20
    fill_in "elem3[description]", :with => "Spesa di prova n. 3"
    select "Cibo", :from => "elem3[category_id]"


    click_button "Save"
    Expense.count.should eql(3)  
  end

  
end
