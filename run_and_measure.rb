#!/usr/bin/ruby
collected_times = []

selects = 0
test_cmd = open("| rake spec:models")
log_cmd =  open("| tail -f log/test.log")
while (not test_cmd.gets =~ /examples/) do
  while true do 
    line = log_cmd.gets
    if line =~ /SELECT/
      selects += 1
      puts "I found #{selects} SELECTS"
    end
    exit if not line
  end
end