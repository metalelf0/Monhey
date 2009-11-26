Given /^I have a category named (.+)$/ do |category_name|
  Category.create!(:name => category_name)
end

Given /^I have expenses with description (.+) in category (.+) and in account (.+)$/ do |descriptions, category, account|
  descriptions.split(", ").each do |description|
    Expense.create!(:description => description, 
                    :category => Category.find_by_name(category), 
                    :amount => 1,
                    :date => Date.today,
                    :account => Account.find_by_name(account),
                    :buoni => 0)
  end
end


Given /^I have an account named (.+)$/ do |account_name|
  Account.create!(:name => account_name)
end