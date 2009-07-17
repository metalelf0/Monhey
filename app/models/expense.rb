class Expense < ActiveRecord::Base
	validates_presence_of :description
	validates_numericality_of :amount
	
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

end

class Date
	
	def month_after
		self >> 1
	end
	
	def month_before
		self << 1
	end

end
