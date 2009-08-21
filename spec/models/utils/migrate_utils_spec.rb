require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe MigrateUtils do
  
  before(:each) do
    Expense.delete_all
    Category.delete_all
    Account.delete_all
  end

  it "should correctly migrate expenses" do
    category = Category.create!(:name => "Category one")
    account_contanti = Account.create!(:name => "Contanti")
    account_bancomat = Account.create!(:name => "Bancomat")
  
    expense_contanti = Expense.create!(
      :description => "Third", 
      :amount => -400,
      :date => Date.parse("2009/01/01"),
  	  :category => category, 
  	  :bancomat => false)
    expense_bancomat = Expense.create!(
      :description => "Third", 
      :amount => -400,
      :date => Date.parse("2009/01/01"),
  	  :category => category,
  	  :bancomat => true)
  
    MigrateUtils.migrate_and_save(expense_contanti)
    MigrateUtils.migrate_and_save(expense_bancomat)
    
    expense_contanti.account.should eql(account_contanti)
    expense_bancomat.account.should eql(account_bancomat)
  
  end
  
end
