include ExpensesHelper

class ExpenseRepository
  
  attr_reader :user
  
  def initialize user=nil
    @user = user
  end
  
  def expenses
    Expense.by_user_id(user.id)
  end

  def expenses_by_year_and_month params
    date = params[:date]
    start_date, end_date = start_and_end_of_month(date)
    expenses.between(start_date, end_date)
  end

  def total_for_month params
    expenses_by_year_and_month(params).sum(&:amount)
  end
  
  def left_for_month(params)
    date, wage = params[:date], params[:wage]
    wage + total_for_month(:date => date)
  end
  
  def daily_average_for_month params
    date = params[:date]
    total = total_for_month params
    days_passed = (date.is_in_current_month ? Date.today.day : date.end_of_month.day)
    total.to_f / days_passed
  end
  
  
  # TODO: move this somewhere else
  def prevision_for_month params
    date = params[:date]
    wage = params[:wage] || 0
    return wage + daily_average_for_month(:date => date) * date.end_of_month.day
  end
  
  def expenses_by_year_month_and_category params
    date = params[:date]
    category_name = params[:category_name]
    expenses_by_year_and_month(:date => date).select { |e| e.category.name == category_name }
  end

  # OLD METHODS
  
  def total_for_month_by_category date, category_name
    start_date, end_date = start_and_end_of_month(date)
    Expense.sum(:amount, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name = ?", start_date, end_date, category_name])
  end 

end
