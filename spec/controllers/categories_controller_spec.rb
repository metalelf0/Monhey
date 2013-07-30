require 'spec_helper'

describe CategoriesController do

  before do
    @user = stub_current_user
  end

  context "#index" do

    it "filters categories by current user" do
      categories = [ stub_model(Category), stub_model(Category) ]
      @user.stub(:categories).and_return categories
      get :index
      assigns[:categories].should == categories
    end

  end

  context "#show" do

    it "should redirect to root when trying to access another user's category" do
      category = stub_model Category
      category.stub :user => stub_model(User)
      Category.stub(:find).with("3").and_return category
      get :show, :id => 3
      response.should redirect_to root_url
    end

  end

  context "#edit" do

    it "should redirect to root when trying to access another user's category" do
      category = stub_model Category
      category.stub :user => stub_model(User)
      Category.stub(:find).with("3").and_return category
      get :edit, :id => 3
      response.should redirect_to root_url
    end

  end

  context "#update" do

    it "should redirect to root when trying to access another user's category" do
      category = stub_model Category
      category.stub :user => stub_model(User)
      Category.stub(:find).with("3").and_return category
      post :update, :id => 3
      response.should redirect_to root_url
    end

  end

  context "#destroy" do

    it "should redirect to root when trying to access another user's category" do
      category = stub_model Category
      category.stub :user => stub_model(User)
      Category.stub(:find).with("3").and_return category
      post :destroy, :id => 3
      response.should redirect_to root_url
    end

  end

  private

  def stub_current_user
    current_user = stub_model User
    User.stub(:first).and_return current_user
    return current_user
  end

end
