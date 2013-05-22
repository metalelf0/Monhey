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
    Expense.by_user_id(user.id).between(start_date, end_date)
  end

  def total_for_month date
    start_date, end_date = start_and_end_of_month(date)
    Expense.sum(:amount, :conditions => ["date BETWEEN ? AND ?", start_date, end_date])
  end
  
  def find_by_year_month_and_category date, category_name
    start_date, end_date = start_and_end_of_month(date)
    Expense.find(:all, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name = ?", start_date, end_date, category_name])    
  end
  
  def total_for_month_by_category date, category_name
    start_date, end_date = start_and_end_of_month(date)
    Expense.sum(:amount, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name = ?", start_date, end_date, category_name])
  end 

end