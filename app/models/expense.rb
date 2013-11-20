include ExpensesHelper

class Expense < ActiveRecord::Base

  belongs_to :category
  belongs_to :user
  
  validates_presence_of :description, :category, :user_id
  validates_numericality_of :amount

  default_scope :order => :date
  
  scope :between, lambda { |start_date, end_date| { :conditions => ['date >= ? AND date <= ?', start_date, end_date ] } }
  scope :for_budget, -> { where(include_in_budget: true) } 
  
end

class Date
  
  def is_in_current_month
    return ((self.year == Date.today.year) && (self.month == Date.today.month))
  end
  
end
