require "pp"
require 'rubygems'
require 'activerecord'
require 'config/environment.rb'

ENV["RAILS_ENV"] = "test"
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
    can be one of c(ategories), d(elete), i(nsert), I(nteractive insert), l(ist), h(elp)

  Insert mode parameters:
    -d <description> -a <amount> -b <bancomat> (true or false) -u <ufficio> (true or false) -c <category> -y <day> (YYYY/MM/DD) -p <buoniPasto>
    
  List mode parameters:
    -r <year> <month>: specifies a month to display expenses from"
end

def printEntriesTable arguments
    if arguments["-r"].nil?
        puts "Li stampo tutti"
        expenses = Expense.all
    else
        puts "Ne stampo solo un po'"
        expenses = expensesIn(arguments["-r"][0].to_i, arguments["-r"][1].to_i)
    end
  n = 0
  puts "N\tDate    \tAmount  \tDescription              \tCategory  \tBuoni  \tUff.  \tBan."
  puts "------------------------------------------------------------------------------------------------------------"
  expenses.each do |exp|
    puts "#{n}\t#{exp.date}\t#{exp.amount.to_s.pad_to(8)}\t#{exp.description.pad_to(25)}\t#{exp.category.pad_to(10)}\t#{exp.buoni.to_s.pad_to(5)}\t#{exp.ufficio ? "X" : " "}\t#{exp.bancomat ? "X" : " "}"
    n = n+1
  end
end

def readArgumentsInteractively arguments
    arguments[DESCRIPTION] = ""
    while arguments[DESCRIPTION].blank? or arguments[DESCRIPTION].nil?
      print "Enter description: > "
      arguments[DESCRIPTION] = readline[0..-2]
    end
    print "Enter amount:      > " 
    arguments[AMOUNT] = readline[0..-2]
    print "Enter category:    > "
    arguments[CATEGORY] = readline[0..-2]
    print "Enter date:        > "
    arguments[DATE] = readline[0..-2]
    print "Enter buoni pasto: > "
    arguments[BUONI] = readline[0..-2]
    arguments[BANCOMAT] = ""
    while arguments[BANCOMAT].nil? or arguments[BANCOMAT].blank? or !["S", "N", "s", "n"].include? arguments[BANCOMAT][0..0]
      print "Bancomat? (S/N)    > "
      arguments[BANCOMAT] = readline[0..-2]      
    end
    
    arguments[UFFICIO] = ""
    while arguments[UFFICIO].nil? or arguments[UFFICIO].blank? or !["S", "N", "s", "n"].include? arguments[UFFICIO][0..0]
      print "Ufficio?  (S/N)    > "
      arguments[UFFICIO] = readline[0..-2]
    end
end

def buildExpenseFromParams arguments
  pp arguments
  exp = Expense.create(  
    "description" => arguments[DESCRIPTION],
    "amount"      => arguments[AMOUNT],
    "category"    => arguments[CATEGORY],
    "bancomat"    => ((["S", "s", "true"].include? arguments[BANCOMAT]) ? true : false),
    "ufficio"     => ((["S", "s", "true"].include? arguments[UFFICIO])  ? true : false),
    "date"        => ((arguments[DATE].nil? or arguments[DATE].blank?)? Date.today : Date.parse(arguments[DATE]) ),
    "buoni"       => arguments[BUONI].to_i
  )
  return exp
end


def buildAndSaveExpenseFromParams arguments
  exp = buildExpenseFromParams arguments
  exp.save
  if exp.errors.size > 0
    puts exp.errors
    return exp
  else
    puts "\n\nExpense saved with id #{exp.id}!"
    return exp
  end
end

def deleteExpense index
  if (index.is_a? String) and (INTEGER_RE.match index) and (index.to_i < Expense.all.size)
    exp = Expense.all[index.to_i]
    exp.destroy
  else
    puts "Invalid index"
  end
end

def expensesIn year, month
    return Expense.all
end

def expensesFromTo startYear, startMonth, endYear, endMonth
    return Expense.all
end