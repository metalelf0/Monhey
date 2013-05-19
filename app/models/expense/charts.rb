class Expense
  module Charts
   
   MAX_CLOUD_SIZE = 32
   MIN_CLOUD_SIZE = 12
    
   def Expense.font_size_for_tag_cloud(total, lowest, highest)
      return "font-size:#{ MAX_CLOUD_SIZE.to_s }px;" if ((total != 0) && (total == lowest) && (lowest == highest))
      return nil if total.nil? or highest.nil? or lowest.nil?
      return "display:none;" if (total == 0)
      spread = highest - lowest
      spread_2 = MAX_CLOUD_SIZE - MIN_CLOUD_SIZE
      c = spread_2 / spread
      size = MAX_CLOUD_SIZE - ((total - lowest) * c) 

      size_txt = "font-size:#{ size.round.to_s }px;"
      return size_txt
    end
    
    def Expense.generate_hash_for_categories_cloud(date)
      hash = {}
      monthly_categories_report = monthly_categories_report(date)
      lowest  = monthly_categories_report.values.sort.first
      highest = monthly_categories_report.values.sort.last

      monthly_categories_report.each_pair do |category, total|
        hash[category] = {}
        hash[category][:style] = Expense.font_size_for_tag_cloud(
          total,
          lowest,
          highest)
        hash[category][:amount] = total
      end
      return hash
    end
    
    # GOOGLE CHART METHODS #
    # "http://chart.apis.google.com/chart?cht=p&chd=t:129,47,144,31&chs=250x100&
    # chl=Altro|Benza|Cibo|Elettronica&chco=FF0000"
    
     def Expense.generate_expenses_pie_chart(date)
       category_amounts = Expense.monthly_categories_report(date)
       base_url = "http://chart.apis.google.com/chart?cht=p&chd=t:"
       categories = ""
       category_amounts.each_pair do |category, amount|
         if amount < 0
           base_url += amount.to_f.round.abs.to_s+","
           categories += URI.encode(category+"|")
         end
       end
       # remove last "|"
       categories = categories.gsub(/%7C$/,"")
       base_url = base_url[0..-2]+"&chs=350x150&chl="+categories+"&chco=FF0000"
       return base_url
     end

     def Expense.generate_daily_chart_for(date)
       amounts = Expense.amounts_by_date_for_month(date)
       return "http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:" + amounts + "&chxl=0:|" + daily_labels_for_month_of(date) + "|1:|0|250|500|750|1000&chs=500x150&chds=0,1000"  
     end
   
   end
end
    
