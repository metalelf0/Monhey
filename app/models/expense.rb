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

end

class Date
	
	def month_after
		self >> 1
	end
	
	def month_before
		self << 1
	end

end
