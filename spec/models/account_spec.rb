require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Account do
  
  it "should retrieve the right Bancomat and Contanti accounts" do
    Account.should_receive(:find_by_name).with("Bancomat")
    Account.should_receive(:find_by_name).with("Contanti")
    
    Account.bancomat
    Account.contanti
  end
  
  it "should use is_bancomat and is_contanti methods correctly" do
    bancomat = Account.new(:name => "Bancomat")
    contanti = Account.new(:name => "Contanti")

    bancomat.is_contanti?.should be_false
    bancomat.is_bancomat?.should be_true
    
    contanti.is_contanti?.should be_true
    contanti.is_bancomat?.should be_false
    
    
  end
  
end