class Expense < ActiveRecord::Base
	validates_presence_of :description
	validates_numericality_of :amount
	

	def Expense.find_by_year_month year, month
		start_date = Date.parse("#{year}/#{month}/01")
		end_date = (start_date >> 1) - 1 # 1 month after, 1 day before XD
		puts Expense.count.to_s + " expenses"
		Expense.find(:all).select { |expense| expense.date.between?(start_date, end_date) }
	end
end
