class Expense < ActiveRecord::Base
	validates_presence_of :description
	validates_numericality_of :amount
end
