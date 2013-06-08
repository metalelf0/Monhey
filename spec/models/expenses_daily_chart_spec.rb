require 'spec_helper'

describe ExpensesDailyChart do

  
  let!(:date) { Date.new(2013, 1, 1) } 
  let!(:user) { Factory(:user) }
  let!(:category) { Factory(:category, :name => "Food") }
  let!(:expense) { Factory(:expense, :amount => -10.0, :category => category, :user => user, :date => date) } 

  subject { ExpensesDailyChart.new(:user => user, :date => date) } 

  its(:url) { should ==  'http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:10.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0&chxl=0:|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|1:|0|250|500|750|1000&chs=500x150&chds=0,1000' }
  
end
