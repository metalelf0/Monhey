class Expense < ActiveRecord::Base
	
	CATEGORIES_ARRAY = ["Altro", "Benza", "Cibo", "Elettronica", "Prelievo bancomat"]

  CATEGORIES = ModelHelper.build_categories_option_list_from_array(CATEGORIES_ARRAY)
  
	
	validates_presence_of :description, :category
	validates_numericality_of :amount
	validates_inclusion_of :category,
	  :in => CATEGORIES_ARRAY,
	  :message => "is not a valid category"  
	
	  	
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

  def Expense.categories
    CATEGORIES
  end
  
  def Expense.average_for_month(year, month, total)
    days_in_month = (Date.new(year.to_i, month.to_i + 1, 1) -1).day
    daily_exp = total.to_f / days_in_month
    return daily_exp
  end
  
  def Expense.average_for_current_month(total)
    daily_exp = total.to_f / Date.today.day
    return daily_exp
  end
  

  def Expense.total_for_bancomat_in(expenses)
    expenses.select { |e| e.bancomat }.inject(0) { |total, e| total + e.amount }
  end

  def Expense.prevision_for_current_month(current_total)
    year = Date.today.year; month = Date.today.month
    days_in_month = (Date.new(year.to_i, month.to_i + 1, 1) -1).day
    daily_exp = current_total.to_f / Date.today.day
    daily_exp * days_in_month
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
