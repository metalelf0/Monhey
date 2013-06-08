class ExpensesDailyChart

  GOOGLE_CHART_BASE_URL =  "http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:"

  attr_accessor :user, :date, :url

  def initialize args
    args.each do |key, value|
      self.send("#{key}=", value)
    end
    @url = generate_url
  end

  def generate_url
    amounts = user.amounts_by_date_for_month(:date => date)
    return "http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:" + amounts + "&chxl=0:|" + daily_labels_for_month_of(date) + "|1:|0|250|500|750|1000&chs=500x150&chds=0,1000"  
  end

  def daily_labels_for_month_of(date)
    start_date, end_date = start_and_end_of_month(date)
    start_day, end_day = start_date.day, end_date.day
    dates_string = ""
    start_day.upto(end_day) do |day|
      dates_string.concat(day.to_s + "|")
    end
    return dates_string[0..-2]
  end

end
