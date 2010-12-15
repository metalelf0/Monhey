require 'fastercsv'
require 'pp'

class ExpenseImporter

  attr_accessor :path
  attr_accessor :mode

  def initialize path, mode=:standard
    @path = path
    configure_for mode
  end

  def import_row parsed_row
    Expense.create(:date => Date.parse(parsed_row[ @fields[:date] ]), 
                   :amount => parsed_row[ @fields[:amount] ],
                   :description => parsed_row[ @fields[:description] ], 
                   :category => Category.find_or_create_by_name(parsed_row[ @fields[:category] ]))
  end
  
  def import
    FasterCSV.foreach(@path, {:col_sep => @col_sep}) do |parsed_row|
      import_row parsed_row
    end
  end

  private
  
  def configure_for mode
    if mode == :standard
      @fields = {
        :date => 0,
        :amount => 1,
        :description => 2,
        :category => 3
      }
      @col_sep = ','
    elsif mode == :easymoney
      @fields = {
        :date => 4,
        :amount => 2,
        :description => 0,
        :category => 1
      }
      @col_sep = '|'
    end
    
  end

end
