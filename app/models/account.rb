class Account < ActiveRecord::Base

  has_many :expenses
  has_many :movements_out, :class_name => "Movement", :foreign_key => "from_account_id"
  has_many :movements_in, :class_name  => "Movement", :foreign_key => "to_account_id"
   
  # TODO: write tests for these methods
  
  def bancomat
    return (self.name == "Bancomat")
  end
  
  def contanti
    return (self.name == "Contanti")
  end
  
  def Account.bancomat
    Account.find_by_name("Bancomat")
  end

  def Account.contanti
    Account.find_by_name("Contanti")
  end

end
