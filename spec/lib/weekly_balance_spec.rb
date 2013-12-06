require 'spec_helper'

describe WeeklyBalance do

  let(:valid_args) { { week_number: 1, upper_limit: 100, current_budget: 10 } }
  subject { described_class.new valid_args }

  its(:week_number) { should == 1 }
  its(:upper_limit) { should == 100 }
  its(:current_budget) { should == 10 }

end
