require 'spec_helper'



### November 2013
###
### Monday         *4 11 18 25
### Tuesday         5 12 19 26
### Wednesday       6 13 20 27
### Thursday        7 14 21 28
### Friday       1  8 15 22 29
### Saturday     2  9 16 23 30
### Sunday       3 10 17 24

describe Week do

  let(:date) {Date.new(2013, 11, 4)  }
  subject { Week.new date }

  it { should have(7).days }

  context "knows which month it belongs to" do

    it "belongs to a month when all week days are inside the month" do
      subject.month.should == 11
    end

    context "first week of month" do

      it "belongs to previous month when at least 4 days are in previous month" do
        ### September 2013

        ### Monday          2  9 16 23 30
        ### Tuesday         3 10 17 24
        ### Wednesday       4 11 18 25
        ### Thursday        5 12 19 26
        ### Friday          6 13 20 27
        ### Saturday        7 14 21 28
        ### Sunday      *1  8 15 22 29

        date = Date.new 2013, 9, 1
        week = Week.new date
        week.month.should == 8
      end

      it "belongs to current month when at least 4 days are inside current month" do
        ### August 2013

        ### Monday          5 12 19 26
        ### Tuesday         6 13 20 27
        ### Wednesday       7 14 21 28
        ### Thursday    *1  8 15 22 29
        ### Friday       2  9 16 23 30
        ### Saturday     3 10 17 24 31
        ### Sunday       4 11 18 25

        date = Date.new 2013, 8, 1
        week = Week.new date
        week.month.should == 8
      end

    end

    context "last week of month" do

      it "belongs to next month when at least 4 days are in next month" do
        ### September 2013

        ### Monday          2  9 16 23 *30
        ### Tuesday         3 10 17 24
        ### Wednesday       4 11 18 25
        ### Thursday        5 12 19 26
        ### Friday          6 13 20 27
        ### Saturday        7 14 21 28
        ### Sunday       1  8 15 22 29
        #
        date = Date.new 2013, 9, 30
        week = Week.new date
        week.month.should == 10
      end

      it "belongs to current month when at least 4 days are inside current month" do
        ### November 2013
        ###
        ### Monday          4 11 18 *25
        ### Tuesday         5 12 19  26
        ### Wednesday       6 13 20  27
        ### Thursday        7 14 21  28
        ### Friday       1  8 15 22  29
        ### Saturday     2  9 16 23  30
        ### Sunday       3 10 17 24

        date = Date.new 2013, 9, 25
        week = Week.new date
        week.month.should == 9
      end

    end

  end

end
