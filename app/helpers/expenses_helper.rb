module ExpensesHelper

  def start_and_end_of_month year, month
    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month
    [start_date, end_date]
  end

end
