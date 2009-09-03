require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Account do
  
  before :each do
    Account.delete_all
  end
  
  it "should retrieve the right Bancomat and Contanti accounts" do
    Account.bancomat.should be_nil
    Account.contanti.should be_nil
    
    bancomat = Account.create!(:name => "Bancomat")
    contanti = Account.create!(:name => "Contanti")
    
    Account.bancomat.should eql(bancomat)
    Account.contanti.should eql(contanti)
  end
  
  it "should use is_bancomat and is_contanti methods correctly" do
    bancomat = Account.create!(:name => "Bancomat")
    contanti = Account.create!(:name => "Contanti")

    bancomat.is_contanti?.should be_false
    bancomat.is_bancomat?.should be_true
    
    contanti.is_contanti?.should be_true
    contanti.is_bancomat?.should be_false
    
    
  end
  
end