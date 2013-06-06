include ExpensesHelper

class Expense < ActiveRecord::Base

  include Expense::Charts

  belongs_to :category
  belongs_to :account
  belongs_to :user
  
  validates_presence_of :description, :category, :user_id
  validates_numericality_of :amount

  default_scope :order => :date
  
  scope :between, lambda { |start_date, end_date| { :conditions => ['date >= ? AND date <= ?', start_date, end_date ] } }
  scope :by_user_id, lambda { |user_id| where("user_id = ?", user_id) }
      
  # def Expense.amounts_for_categories(date)
  def Expense.monthly_categories_report(date)
    hash = Hash.new
    Category.all.map(&:name).each do |category|
      hash[category] = ExpenseRepository.new.total_for_month_by_category date, category
    end
    hash
  end

  def Expense.total_for_day(date)
    Expense.find_all_by_date(date).sum {|exp| exp.amount }
  end
  
  def Expense.amounts_by_date_for_month(date)
    start_date, end_date = start_and_end_of_month(date)
    expenses = Expense.between(start_date, end_date)
    daily_expenses = ""
    start_date.upto(end_date) do |date|
      daily_expenses += (-1 * expenses.select {|e| e.date == date }.sum(&:amount)).to_s + ","
    end
    return daily_expenses.gsub(/,$/, "")
  end
  
end

class Date
  
  def is_in_current_month
    return ((self.year == Date.today.year) && (self.month == Date.today.month))
  end
  
end
