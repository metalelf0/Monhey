require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Creating an entry" do

  it "should_save_an_entry_through_the_first_edit_field" do
    Expense.count.should eql(0)
    visit 'expenses'
    # puts @response.body
    fill_in "elem1[amount]", :with => -10
    fill_in "elem1[buoni]", :with => 1
    fill_in "elem1[description]", :with => "Spesa di prova"
    select "Altro", :from => "elem1_category"
    click_button "Save"
    Expense.count.should eql(1)
    Expense.first.description.should eql("Spesa di prova") 
    Expense.first.amount.should eql(-10.0)
  end
  
end
