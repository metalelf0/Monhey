include ExpensesHelper

class Expense < ActiveRecord::Base


  belongs_to :category
  belongs_to :account
  
  validates_presence_of :description, :category
  validates_numericality_of :amount   

  def Expense.find_by_year_month params
    if not params[:month].nil? and not params[:year].nil?
      date = Date.new( params[:year].to_i, params[:month].to_i, 1)
    elsif not params[:date].nil?
      date = params[:date]
    end
    start_date, end_date = start_and_end_of_month(date)
    Expense.find(:all, :conditions => ["date >= ? AND date <= ?", start_date, end_date])
  end

  
  def Expense.average_for_month date
    days_in_month = date.end_of_month.day
    total = Expense.total_for_month date
    daily_exp = total.to_f / days_in_month
    return daily_exp
  end

  def Expense.in_current_month
    Expense.find_by_year_month(:date => Date.today)
  end
    
  def Expense.total_for_month date
    start_date, end_date = start_and_end_of_month(date)
    Expense.sum(:amount, :conditions => ["date >= ? AND date <= ?", start_date, end_date])
  end

  def Expense.find_by_year_month_and_category date, category_name
    start_date, end_date = start_and_end_of_month(date)
    Expense.find(:all, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date >= ? AND date <= ? AND cat.name = ?", start_date, end_date, category_name])    
  end
  
  def Expense.total_for_month_by_category date, category_name
    start_date, end_date = start_and_end_of_month(date)
    Expense.sum(:amount, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date >= ? AND date <= ? AND cat.name = ?", start_date, end_date, category_name])
  end
  
  def Expense.total_for_current_month
    Expense.total_for_month Date.today
  end
  
  def Expense.average_for_current_month
    total = Expense.total_for_current_month
    daily_exp = total.to_f / Date.today.day
    return daily_exp
  end
  
  def Expense.total_for_bancomat_in_month date
    start_date, end_date = start_and_end_of_month(date)
    return Expense.sum(:amount, :joins => "INNER JOIN accounts as acc ON account_id = acc.id", :conditions => ["date >= ? AND date <= ? AND acc.name = 'Bancomat'", start_date, end_date])
  end

  def Expense.prevision_for_current_month
    current_total = Expense.total_for_current_month
    year = Date.today.year; month = Date.today.month
    days_in_month = ModelHelper.days_in_month_of year, month
    daily_exp = current_total.to_f / Date.today.day
    daily_exp * days_in_month
  end

  def Expense.left_for_current_month_with_stipendio(stipendio)
    start_date, end_date = start_and_end_of_month(Date.today)
    return stipendio + Expense.sum(:amount, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date >= ? AND date <= ? AND cat.name != 'Stipendio'", start_date, end_date])
  end
  
  def Expense.amounts_for_categories(date)
    hash = {}
    Category.all.map(&:name).each do |category|
      hash[category] = Expense.total_for_month_by_category date, category
    end
    hash
  end
  
  def Expense.generate_hash_for_categories_cloud(date)
    hash = {}
    amounts_for_categories = amounts_for_categories(date)
    lowest  = amounts_for_categories.values.sort.first
    highest = amounts_for_categories.values.sort.last
    
    amounts_for_categories.each_pair do |category, total|
      hash[category] = {}
      hash[category][:style] = Expense.font_size_for_tag_cloud(
        total,
        lowest,
        highest)
      hash[category][:amount] = total
    end
    return hash
  end
  
  def Expense.font_size_for_tag_cloud( total, lowest, highest)
    return nil if total.nil? or highest.nil? or lowest.nil?
    return "display:none;" if (total == 0 || highest == 0)
  if highest == 0 and lowest == 0
    size = 12
    else
      size = 8 + 24 * total / highest;
    end  
    # display the results
    size_txt = "font-size:#{ size.round.to_s }px;"
    return size_txt
  end

end