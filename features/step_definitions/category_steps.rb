When /^I visit detail page for category "([^\"]*)"$/ do |category_name|
  cat = Category.find_by_name(category_name)
  visit category_url(cat)
end

Given /^I have a category named "([^\"]*)"$/ do |category_name|
  Factory(:category, :name => category_name)
end

