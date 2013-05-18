include ExpensesHelper

class Expense < ActiveRecord::Base

  include Expense::Charts

  belongs_to :category
  belongs_to :account
  
  validates_presence_of :description, :category
  validates_numericality_of :amount   

  def Expense.average_for_month date
    days_passed = (date.is_in_current_month ? Date.today.day : date.end_of_month.day)
    total = Expense.total_for_month date
    total.to_f / days_passed
  end
      
  def Expense.amounts_for_categories(date)
    hash = Hash.new
    Category.all.map(&:name).each do |category|
      hash[category] = Expense.total_for_month_by_category date, category
    end
    hash
  end
  
  def Expense.amounts_by_date_for_month(date)
    start_date, end_date = start_and_end_of_month(date)
    daily_expenses = ""
    start_date.upto(end_date) do |date|
      daily_expenses += (-1 * Expense.total_for_day(date)).to_s + ","
    end
    return daily_expenses[0..-2]
  end
  
  def Expense.total_for_day(date)
    Expense.find_all_by_date(date).sum {|exp| exp.amount }
  end

  def Expense.prevision_for_month date
    if date.is_in_current_month 
      return Expense.average_for_month(date) * date.end_of_month.day
    else
      return Expense.total_for_month(date)
    end
  end
  
  def Expense.in_current_month #TODO: is this shit still needed?
    ExpenseRepository.find_by_year_month_and_category(:date => Date.today)
  end
  
  def Expense.left_for_month_with_stipendio(date, stipendio)
    today = Date.today
    if (date.is_in_current_month)
      start_date, end_date = start_and_end_of_month(today)
      return stipendio - Expense.sum(:amount, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name != 'Stipendio'", start_date, end_date])
    else
      if date > today
        return stipendio.to_f
      else
        return stipendio - Expense.total_for_month(date)
      end
    end
  end

end

class Date
  
  def is_in_current_month
    return ((self.year == Date.today.year) && (self.month == Date.today.month))
  end
  
end
