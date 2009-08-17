require 'fastercsv'
require 'pp'

class ExpenseCsvImporter

  attr_accessor :path

  def initialize path
    @path = path
  end

  def import_line line
    attributes = FasterCSV::parse(line)[0]
    Expense.create(:date => attributes[0], :amount => attributes[1],
      :description => attributes[2], :category => Category.find_or_create_by_name(attributes[3]))
  end
  
  def import
    File.read(@path).each do |line|
      import_line line
    end
  end

end
