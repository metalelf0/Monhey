class User < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :authorizations
  validates :name, :email, :presence => true
  delegate :expenses, :expenses_by_year_and_month, :to => :expense_repository
  
  def expense_repository
    @expense_repository ||= ExpenseRepository.new(self)
  end
  
  def add_provider(auth_hash)
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end
  
end
