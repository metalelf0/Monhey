#!/usr/bin/env ruby
# TODO: ma come si faceva a usare la console di Rails anziche' ruby?
require 'lib/consoleLibs.rb'
include ConsoleLibs

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
  exp= build_and_save_expense_from_params arguments
elsif 'c' == arguments[MODE]
  pp Expense.categories_array
elsif 'h' == arguments[MODE]
  printHelp
elsif 'l' == arguments[MODE] or 'r' == arguments[MODE]
  print_entries_table arguments
elsif "I" == arguments[MODE]
    puts "Entering interactive mode: "
    read_arguments_interactively arguments 
    build_and_save_expense_from_params arguments
    exit
elsif "d" == arguments[MODE]
    print_entries_table Expense.all
    puts "Enter index of expense to delete: > "
    index = gets
    delete_expense index
else
  puts "Wrong mode specified (call with -m h for help)"
  exit(-1)
end
