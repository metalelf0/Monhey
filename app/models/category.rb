class Category < ActiveRecord::Base

  has_many :expenses

  def totals_for_year(year)
    totals = []
    1.upto(12) do |month|
			totals << Expense.total_for_month_by_category (Date.new(year, month, 1), self.name ) 
		end 
		totals
  end

end
