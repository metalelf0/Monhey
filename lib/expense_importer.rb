require 'fastercsv'
require 'pp'
include ConsoleLibs

class ExpenseImporter

  attr_accessor :path
  attr_accessor :mode

  def initialize path, mode=:standard
    @path = path
    configure_for mode
  end

  def import_row parsed_row
    if @date_format == :italian 
      date_args = parsed_row[ @fields[:date] ].strip.split('/')
      date = Date.new(date_args[2].to_i, date_args[1].to_i, date_args[0].to_i)
    else
      date = Date.parse(parsed_row[ @fields[:date] ]) 
    end
    Expense.create!(:date => date, 
                   :amount => expense_from_string(parsed_row[ @fields[:amount] ]),
                   :description => parsed_row[ @fields[:description] ].strip, 
                   :account => Account.find_or_create_by_name("CartaSi"),
                   :category => Category.find_or_create_by_name(parsed_row[ @fields[:category] ].strip))
  end

  def expense_from_string string
    0 - string.gsub(",", ".").to_f
  end
  
  
  def import
    FasterCSV.foreach(@path, {:col_sep => @col_sep}) do |parsed_row|
      begin
        import_row parsed_row
      rescue Exception => e
        console_puts "Error importing row: #{e}" 
      end
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
    elsif mode == :cartasi
      @fields = {
        :date => 2,
        :amount => 5,
        :description => 6,
        :category => 4 
      }
      @col_sep = '|'
      @date_format = :italian
    end
    
  end

end
