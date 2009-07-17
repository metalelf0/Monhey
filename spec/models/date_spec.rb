require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Date do
  before(:each) do
  
  end

	after(:each) do
		
	end
	
	it "should retrieve the first day of the next month correctly" do
		d = Date.parse "2009/12/01"
		y = d.month_after
		y.day.should eql(1)
		y.month.should eql(1)
		y.year.should eql(2010)
	end

	it "should retrieve the first day of the previous month correctly" do
		d = Date.parse "2010/01/01"
		y = d.month_before
		y.day.should eql(1)
		y.month.should eql(12)
		y.year.should eql(2009)
	end
    
end
