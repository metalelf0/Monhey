require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Movement do

  it "should have accounts" do
    from_account = mock_model(Account, :name => "from")
    to_account   = mock_model(Account, :name => "to")
    Movement.new.should_not be_valid
    Movement.new(:from_account => from_account, :to_account => to_account).should be_valid
  end

  it "should be from an account to a different one" do
    from_and_to_account = mock_model(Account, :name => "from")
    Movement.new(:from_account => from_and_to_account, :to_account => from_and_to_account).should_not be_valid
  end


end
