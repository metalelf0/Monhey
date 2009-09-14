module ExpensesHelper

  def start_and_end_of_month date
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    [start_date, end_date]
  end

  def labels_for(date)
    start_date, end_date = start_and_end_of_month(date)
    start_day, end_day = start_date.day, end_date.day
    dates_string = ""
    start_day.upto(end_day) do |day|
      dates_string.concat(day.to_s + "|")
    end
    return dates_string[0..-2]
  end

end
