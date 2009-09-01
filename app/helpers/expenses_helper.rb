module ExpensesHelper

  def start_and_end_of_month date
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    [start_date, end_date]
  end

end
