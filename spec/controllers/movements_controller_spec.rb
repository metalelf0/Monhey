require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MovementsController do

  integrate_views

  it "should show two select inputs for accounts" do
    get :new
    
    response.should have_tag('select#movement_from_account_id')
    response.should have_tag('select#movement_to_account_id')
  end

end
