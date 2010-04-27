require 'fastercsv'
require 'pp'

class ExpenseCsvImporter

  attr_accessor :path

  def initialize path, mode=:standard
    @path = path
    
  end

  def import_row parsed_row
    Expense.create(:date => parsed_row[0], :amount => parsed_row[1],
      :description => parsed_row[2], :category => Category.find_or_create_by_name(parsed_row[3]))
  end
  
  def import
    FasterCSV.foreach(@path) do |parsed_row|
      import_row parsed_row
    end
  end

end
