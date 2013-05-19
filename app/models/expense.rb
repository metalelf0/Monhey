include ExpensesHelper

class Expense < ActiveRecord::Base

  include Expense::Charts

  belongs_to :category
  belongs_to :account
  
  validates_presence_of :description, :category
  validates_numericality_of :amount
  
  scope :between, lambda { |start_date, end_date| { :conditions => ['created_at >= ? AND created_at <= ?', start_date.beginning_of_day, end_date.end_of_day ] } }

  def Expense.daily_average_for_month date
    days_passed = (date.is_in_current_month ? Date.today.day : date.end_of_month.day)
    total = ExpenseRepository.new.total_for_month date
    total.to_f / days_passed
  end
      
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
    daily_expenses = ""
    start_date.upto(end_date) do |date|
      daily_expenses += (-1 * Expense.total_for_day(date)).to_s + ","
    end
    return daily_expenses[0..-2]
  end
  
  def Expense.prevision_for_month date
    return Expense.daily_average_for_month(date) * date.end_of_month.day
  end
  
  def Expense.in_current_month #TODO: is this shit still needed?
    ExpenseRepository.new.find_by_year_month_and_category(:date => Date.today)
  end
  
  def Expense.left_for_month(date, wage)
    wage + ExpenseRepository.new.total_for_month(date)
  end

end

class Date
  
  def is_in_current_month
    return ((self.year == Date.today.year) && (self.month == Date.today.month))
  end
  
end
