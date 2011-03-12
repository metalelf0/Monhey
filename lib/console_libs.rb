require 'rubygems'
require 'active_record'
require 'lib/string.rb'
require 'config/environment.rb'

module ConsoleLibs

  INTEGER_RE = /(\d)+/

  MODE        = "-m"
  DESCRIPTION = "-d"
  AMOUNT      = "-a"
  ACCOUNT     = "-b"
  CATEGORY    = "-c"
  UFFICIO     = "-u"
  DATE        = "-y"
  RANGE       = "-r"

  def console_puts output
    puts output unless ENV["RAILS_ENV"] == 'test'
  end

  def printHelp
    console_puts "
    *********************************
    * Expenses handler shell script *
    *********************************

    -m <mode>
      can be one of 
       - c(ategories)
       - d(elete)
       - i(nsert)
       - I(nteractive insert)
       - l(ist)
       - h(elp)

    Insert mode parameters:
      -d <description> -a <amount> -b <account_name> -c <category> -y <day> (YYYY/MM/DD) 
      
    List mode parameters:
      -r <year> <month>: specifies a month to display expenses from"
  end

  def expenses_in year, month
    Expense.find_by_year_month(:date => Date.new(year, month, 1))
  end

  def print_entries_table arguments
      if arguments["-r"].nil?
          console_puts "Li stampo tutti"
          expenses = Expense.all
      else
          year, month = arguments["-r"][0].to_i, arguments["-r"][1].to_i
          expenses = expenses_in(year, month)
      end
    n = 0
    console_puts "N\tDate    \tAmount  \tDescription              \tCategory"
    console_puts "------------------------------------------------------------------------------------------------------------"
    expenses.each do |exp|
      console_puts "#{n}\t#{exp.date}\t#{exp.amount.to_s.pad_to(8)}\t#{exp.description.pad_to(25)}\t#{exp.category.name.pad_to(10)}"
      n = n+1
    end
  end

  def read_arguments_interactively arguments
      arguments[DESCRIPTION] = ""
      while arguments[DESCRIPTION].blank?
        arguments[DESCRIPTION] = ask_in_line "description"
      end
      
      arguments[AMOUNT]   = ask_in_line "amount"
      arguments[CATEGORY] = ask_in_line "category"
      arguments[DATE]     = ask_in_line "date"
      arguments[ACCOUNT] = ask_in_line "account"
      end

  def build_expense_from_params arguments
    exp = Expense.create(  
      "description" => arguments[DESCRIPTION],
      "amount"      => arguments[AMOUNT],
      "category"    => Category.find_or_create_by_name(arguments[CATEGORY]),
      "account"     =>  Account.find_or_create_by_name(arguments[ACCOUNT]),
      "date"        => arguments[DATE].blank? ? Date.today : Date.parse(arguments[DATE])
    )
    return exp
  end


  def build_and_save_expense_from_params arguments
    exp = build_expense_from_params arguments
    exp.save
    if exp.errors.size > 0
      console_puts exp.errors
      return exp
    else
      console_puts "\n\nExpense saved with id #{exp.id}!"
      return exp
    end
  end

  def delete_expense index
    if (index.is_a? String) and (INTEGER_RE.match index) and (index.to_i < Expense.all.size)
      exp = Expense.all[index.to_i] #TODO: ma che e' sta porcheria?!
      exp.destroy
    else
      console_puts "Invalid index"
    end
  end

  def ask_for label
    value = ""
    while value.blank? or !value.starts_with_any_of ["S", "N", "s", "n"]
      print "#{label.capitalize}? (S/N)".pad_to(20) + " > "
      value = readline[0..-2]      
    end
    return value
  end

  def ask_in_line label
    print "Enter #{label}:".pad_to(20)+" > " 
    readline[0..-2]
  end
end
