require 'spec_helper'

describe CategoriesPieChart do

  let!(:date) { Date.new(2013, 1, 1) } 
  let!(:user) { Factory(:user) }
  let!(:category) { Factory(:category, :name => "Food") }
  let!(:expense) { Factory(:expense, :amount => -10.0, :category => category, :user => user, :date => date) } 

  subject { CategoriesPieChart.new(:user => user, :date => date) } 

  its(:monthly_categories_report) { should == { "Food" => -10 }  }
  its(:url) { should ==  'http://chart.apis.google.com/chart?cht=p&chd=t:10&chs=350x150&chl=Food&chco=FF0000' }

end

