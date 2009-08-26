class Expense < ActiveRecord::Base


  belongs_to :category
  belongs_to :account
  
  validates_presence_of :description, :category
  validates_numericality_of :amount
  validate :category_is_valid, :message => "is not a valid category"  
   
  
  def category_is_valid 
    unless Category.all.include?(self.category)
      errors.add :category, "Invalid category"
    end
  end 
   

  def Expense.find_by_year_month params
    if not params[:month].nil? and not params[:year].nil?
      month = params[:month].to_i
      year =  params[:year].to_i
    elsif not params[:date].nil?
      month = params[:date].month
      year =  params[:date].year
    end
    start_date = Date.parse("#{year}/#{month}/01")
    end_date = (start_date >> 1) - 1 # 1 month after, 1 day before XD
    Expense.find(:all).select { |expense| expense.date.between?(start_date, end_date) }
  end

  
  def Expense.average_for_month year, month
    days_in_month = (Date.new(year.to_i, month.to_i + 1, 1) -1).day
    total = Expense.total_for_month year, month
    daily_exp = total.to_f / days_in_month
    return daily_exp
  end

  def Expense.in_current_month
    start_date = Date.parse("#{Date.today.year}/#{Date.today.month}/01")
    end_date = (start_date >> 1) - 1
    Expense.find(:all).select { |expense| expense.date.between?(start_date, end_date)}
  end
    
  def Expense.total_for_month year, month
    start_date = Date.parse("#{year}/#{month}/01")
    end_date = (start_date >> 1) - 1
    Expense.find(:all).select { |expense| expense.date.between?(start_date, end_date)}.inject(0.0) {|sum, exp| sum += exp.amount }
  end
  
  def Expense.total_for_current_month
    Expense.total_for_month Date.today.year, Date.today.month
  end
  
  def Expense.average_for_current_month
    total = Expense.total_for_current_month
    daily_exp = total.to_f / Date.today.day
    return daily_exp
  end
  
  def Expense.total_for_bancomat_in expenses
    expenses.select { |e| e.account.bancomat }.inject(0) { |total, e| total + e.amount }
  end

  def Expense.prevision_for_current_month
    current_total = Expense.total_for_current_month
    year = Date.today.year; month = Date.today.month
    days_in_month = ModelHelper.days_in_month_of year, month
    daily_exp = current_total.to_f / Date.today.day
    daily_exp * days_in_month
  end

  def Expense.left_for_current_month_with_stipendio(stipendio)
    total = Expense.in_current_month.inject(0) { |total, expense| (! expense.category.nil? and expense.category.name != "Stipendio") ? total += expense.amount : total}    
    return stipendio + total
  end
    
end



class Date

	def month_after
		self >> 1
	end
	
	def month_before
		self << 1
	end

end
