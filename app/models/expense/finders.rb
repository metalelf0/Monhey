class Expense
  module Finders

    def Expense.find_by_year_month params
      date = params[:date]
      start_date, end_date = start_and_end_of_month(date)
      Expense.find(:all, :conditions => ["date BETWEEN ? AND ?", start_date, end_date])
    end

    def Expense.total_for_month date
      start_date, end_date = start_and_end_of_month(date)
      Expense.sum(:amount, :conditions => ["date BETWEEN ? AND ?", start_date, end_date])
    end

    def Expense.find_by_year_month_and_category date, category_name
      start_date, end_date = start_and_end_of_month(date)
      Expense.find(:all, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name = ?", start_date, end_date, category_name])    
    end
  
    def Expense.total_for_month_by_category date, category_name
      start_date, end_date = start_and_end_of_month(date)
      Expense.sum(:amount, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name = ?", start_date, end_date, category_name])
    end  
  
    def Expense.total_for_bancomat_in_month date
      start_date, end_date = start_and_end_of_month(date)
      return Expense.sum(:amount, :joins => "INNER JOIN accounts as acc ON account_id = acc.id", :conditions => ["date BETWEEN ? AND ? AND acc.name = 'Bancomat'", start_date, end_date])
    end

  end
end