require 'spec_helper'
require 'webrat'

describe ExpensesController do

  describe "index action" do

    before(:each) do
      Date.stub(:today).and_return(Date.new(2009, 1, 10))
      @user = Factory(:user)
      @altro = Factory(:category, :name => "Altro")
      @bancomat = Factory(:account, :name => "Bancomat")
      @first = Factory(:expense,
        :description => "First",
        :amount => -10,
        :date => Date.new(2009,1,1),
        :category => @altro,
        :account => @bancomat,
        :user => @user)
      @second = Factory(:expense,
        :description => "Second",
        :amount => 10,
        :date => Date.new(2009,2,1),
        :category => @altro,
        :account => @bancomat,
        :user => @user)
      @third = Factory(:expense,
        :description => "Third",
        :amount => 20,
        :date => Date.new(2009,3,1),
        :category => @altro,
        :account => @bancomat,
        :user => @user)
    end

    it "should receive a success response and show all the entries" do
      get :index
      response.should be_success
      assigns[:expenses].should eql [@first]
    end

    it "should show only the entries for a given month" do
      get :index, :year => 2009, :month => 2
      response.should be_success
      assigns[:incomes].should eql [@second]
    end

    it "should show only the entries for a given month and category" do
      Expense.stub(:find_by_year_month_and_category).and_return([])
      get :index, :year => 2009, :month => 2, :category_name => "A category without expenses"
      response.should be_success
      assigns[:expenses].should have(0).expenses
    end

  end

end
