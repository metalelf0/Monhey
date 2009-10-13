require "pp"
require 'rubygems'
require 'activerecord'
require 'config/environment.rb'

ENV["RAILS_ENV"] = "development"
INTEGER_RE = /(\d)+/

MODE        = "-m"
DESCRIPTION = "-d"
AMOUNT      = "-a"
CATEGORY    = "-c"
UFFICIO     = "-u"
BANCOMAT    = "-b"
DATE        = "-y"
BUONI       = "-p"
RANGE       = "-r"

class String
  def pad_to tSize
    return self[0..tSize - 1] if self.size > tSize
    spaces = tSize - self.size
    return self + " "*spaces
  end
end

def printHelp
  puts "
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
    -d <description> -a <amount> -b <bancomat> (S or N) -u <ufficio> (S or N) -c <category> -y <day> (YYYY/MM/DD) -p <buoniPasto>
    
  List mode parameters:
    -r <year> <month>: specifies a month to display expenses from"
end

def print_entries_table arguments
    if arguments["-r"].nil?
        puts "Li stampo tutti"
        expenses = Expense.all
    else
        puts "Ne stampo solo un po'"
        expenses = expenses_in(arguments["-r"][0].to_i, arguments["-r"][1].to_i)
    end
  n = 0
  puts "N\tDate    \tAmount  \tDescription              \tCategory  \tBuoni  \tUff.  \tBan."
  puts "------------------------------------------------------------------------------------------------------------"
  expenses.each do |exp|
    puts "#{n}\t#{exp.date}\t#{exp.amount.to_s.pad_to(8)}\t#{exp.description.pad_to(25)}\t#{exp.category.name.pad_to(10)}\t#{exp.buoni.to_s.pad_to(5)}\t#{exp.ufficio ? "X" : " "}\t#{exp.account.is_bancomat? ? "X" : " "}"
    n = n+1
  end
end

def read_arguments_interactively arguments
    arguments[DESCRIPTION] = ""
    while arguments[DESCRIPTION].blank?
      arguments[DESCRIPTION] = ask_in_line "description"
    end
    
    arguments[AMOUNT] = ask_in_line "amount"
    arguments[CATEGORY] = ask_in_line "category"
    arguments[DATE] = ask_in_line "date"
    arguments[BUONI] = ask_in_line "buoni"
    ask_for arguments[BANCOMAT], "Bancomat"
    ask_for arguments[UFFICIO], "Ufficio"
    end

def build_expense_from_params arguments
  pp arguments
  exp = Expense.create(  
    "description" => arguments[DESCRIPTION],
    "amount"      => arguments[AMOUNT],
    "category"    => Category.find_or_create_by_name(arguments[CATEGORY]),
    "account"    => ((["S", "s", "true"].include? arguments[BANCOMAT]) ?
      Account.find_or_create_by_name("Bancomat") :
      Account.find_or_create_by_name("Contanti")),
    "ufficio"     => ((["S", "s", "true"].include? arguments[UFFICIO])  ? true : false),
    "date"        => ((arguments[DATE].nil? or arguments[DATE].blank?)? Date.today : Date.parse(arguments[DATE]) ),
    "buoni"       => arguments[BUONI].to_i
  )
  return exp
end


def build_and_save_expense_from_params arguments
  exp = build_expense_from_params arguments
  exp.save
  if exp.errors.size > 0
    puts exp.errors
    return exp
  else
    puts "\n\nExpense saved with id #{exp.id}!"
    return exp
  end
end

def delete_expense index
  if (index.is_a? String) and (INTEGER_RE.match index) and (index.to_i < Expense.all.size)
    exp = Expense.all[index.to_i]
    exp.destroy
  else
    puts "Invalid index"
  end
end

def expenses_in year, month
    return Expense.all
end

def expenses_from_to startYear, startMonth, endYear, endMonth
    return Expense.all
end

def ask_for value, label
  value = ""
  while value.nil? or value.blank? or !["S", "N", "s", "n"].include? value[0..0]
    print "#{label.capitalize}? (S/N)".pad_to(20) + " > "
    value = readline[0..-2]      
  end
end

def ask_in_line label
  print "Enter #{label}:".pad_to(20)+" > " 
  readline[0..-2]
end
