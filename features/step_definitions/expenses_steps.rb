Given /^I have expenses with description (.+)$/ do |descriptions|
  descriptions.split(", ").each do |description|
    Factory(:expense,
            :description => description,
            :date => Date.today
)
  end
end

Given /^I have the following expenses$/ do |table|
  Expense.delete_all
  table.hashes.each do |hash|
    Factory(:expense, :date => hash[:date], :amount => hash[:amount], :category => Category.find_or_create_by_name(hash[:category_name]))
  end
end

Given /^I have a category with title "([^\"]*)"$/ do |category_name|
  Factory(:category, :name => category_name)
end


Given /^I have an account named (.+)$/ do |account_name|
  Account.create!(:name => account_name)
end

Given /^I have no expenses$/ do
  Expense.delete_all
end

Then /^I should have ([0-9]+) expenses?$/ do |count|
  Expense.count.should eql(count.to_i)
end