class Account < ActiveRecord::Base

  belongs_to :user
  has_many :expenses, :dependent => :destroy
  has_many :movements_out, :class_name => "Movement", :foreign_key => "from_account_id"
  has_many :movements_in, :class_name  => "Movement", :foreign_key => "to_account_id"
  
end
