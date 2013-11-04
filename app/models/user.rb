class User < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :authorizations
  has_many :categories
  validates :name, :email, :presence => true
  delegate :expenses, :expenses_by_year_and_month_weekly, :expenses_by_year_and_month, :total_for_month, :left_for_month, :daily_average_for_month, :prevision_for_month, :expenses_by_year_month_and_category, :total_for_month_by_category, :total_for_day, :amounts_by_date_for_month, :to => :expense_repository
  
  def expense_repository
    @expense_repository ||= ExpenseRepository.new(self)
  end
  
  def add_provider(auth_hash)
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end

  def can_create_expenses?
    !categories.empty?
  end
  
end
