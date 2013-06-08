require 'spec_helper'

describe CategoriesCloudChart do

  let!(:user) { Factory(:user) }
  let!(:date) { Date.new(2013, 1, 1) } 
  let!(:category) { Factory(:category, :name => "Food") }
  let!(:expense) { Factory(:expense, :amount => 10, :date => date, :category => category, :user => user) }

  subject { described_class.new(:user => user, :date => date) }

  its(:monthly_categories_report) { should == { "Food" => 10 }  }
  its(:data_hash)                 { should_not be_nil }
end
