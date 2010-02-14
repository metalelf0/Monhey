require 'spec_helper'

describe MovementsController do

  #Delete these examples and add some real ones
  it "should use MovementsController" do
    controller.should be_an_instance_of(MovementsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      Movement.expects(:all).returns([])
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      Movement.expects(:find).with("1").returns(mock("movement"))
      get 'show', :id => "1"
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      Movement.expects(:find).with("1").returns(mock("movement"))
      get 'edit', :id => "1"
      response.should be_success
    end
  end

end
