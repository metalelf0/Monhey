#!/usr/bin/env ruby
require 'consoleLibs.rb'

arguments = {}

while opt= ARGV.shift
  if opt == "-r"
    arguments[opt] = []
    arguments[opt] << ARGV.shift
    arguments[opt] << ARGV.shift
    break
  end
  arguments[opt] = ARGV.shift
end

if ('i' == arguments[MODE])
  if arguments[AMOUNT].nil? or arguments[DESCRIPTION].nil?
    puts "Devi specificare almeno amount (-a) e description (-d)"
    exit(-1)
  end
  exp= buildAndSaveExpenseFromParams arguments
elsif 'c' == arguments[MODE]
  pp Expense.categories_array
elsif 'h' == arguments[MODE]
  printHelp
elsif 'l' == arguments[MODE] or 'r' == arguments[MODE]
  printEntriesTable arguments
elsif "I" == arguments[MODE]
    puts "Entering interactive mode: "
    readArgumentsInteractively arguments 
    buildAndSaveExpenseFromParams arguments
    exit
elsif "d" == arguments[MODE]
    printEntriesTable Expense.all
    puts "Enter index of expense to delete: > "
    index = gets
    deleteExpense index
else
  puts "Wrong mode specified (call with -h for help)"
  exit(-1)
end
