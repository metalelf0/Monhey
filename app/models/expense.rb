include ExpensesHelper

class Expense < ActiveRecord::Base
  
  MAX_CLOUD_SIZE = 32
  MIN_CLOUD_SIZE = 12


  belongs_to :category
  belongs_to :account
  
  validates_presence_of :description, :category
  validates_numericality_of :amount   

  def Expense.find_by_year_month params
    date = params[:date]
    start_date, end_date = start_and_end_of_month(date)
    Expense.find(:all, :conditions => ["date BETWEEN ? AND ?", start_date, end_date])
  end

  def Expense.average_for_month date
    days_passed = (date.is_in_current_month ? Date.today.day : date.end_of_month.day)
    total = Expense.total_for_month date
    total.to_f / days_passed
  end
    
  def Expense.total_for_month date
    start_date, end_date = start_and_end_of_month(date)
    Expense.sum(:amount, :conditions => ["date BETWEEN ? AND ?", start_date, end_date])
  end

  def Expense.find_by_year_month_and_category date, category_name
    start_date, end_date = start_and_end_of_month(date)
    Expense.find(:all, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name = ?", start_date, end_date, category_name])    
  end
  
  def Expense.total_for_month_by_category date, category_name
    start_date, end_date = start_and_end_of_month(date)
    Expense.sum(:amount, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name = ?", start_date, end_date, category_name])
  end
  
  def Expense.total_for_bancomat_in_month date
    start_date, end_date = start_and_end_of_month(date)
    return Expense.sum(:amount, :joins => "INNER JOIN accounts as acc ON account_id = acc.id", :conditions => ["date BETWEEN ? AND ? AND acc.name = 'Bancomat'", start_date, end_date])
  end
  
  def Expense.amounts_for_categories(date)
    hash = Hash.new
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
  
  
  # generates values in range 12 - 32
  def Expense.font_size_for_tag_cloud(total, lowest, highest)
    return "font-size:#{ MAX_CLOUD_SIZE.to_s }px;" if ((total != 0) && (total == lowest) && (lowest == highest))
    return nil if total.nil? or highest.nil? or lowest.nil?
    return "display:none;" if (total == 0)
    spread = highest - lowest
    spread_2 = MAX_CLOUD_SIZE - MIN_CLOUD_SIZE
    c = spread_2 / spread
    size = 32 - ((total - lowest) * c) 
    
    size_txt = "font-size:#{ size.round.to_s }px;"
    return size_txt
  end

  def Expense.amounts_by_date_for_month(date)
    start_date, end_date = start_and_end_of_month(date)
    daily_expenses = ""
    start_date.upto(end_date) do |date|
      daily_expenses += (-1 * Expense.total_for_day(date)).to_s + ","
    end
    return daily_expenses[0..-2]
  end
  
  def Expense.total_for_day(date)
    Expense.find_all_by_date(date).sum {|exp| exp.amount }
  end

  def Expense.prevision_for_month date
    if date.is_in_current_month 
      return Expense.average_for_month(date) * date.end_of_month.day
    else
      return Expense.total_for_month(date)
    end
  end
  
  def Expense.in_current_month
    Expense.find_by_year_month(:date => Date.today)
  end
  
  def Expense.left_for_month_with_stipendio(date, stipendio)
    today = Date.today
    if (date.is_in_current_month)
      start_date, end_date = start_and_end_of_month(today)
      return stipendio + Expense.sum(:amount, :joins => "INNER JOIN categories as cat ON category_id = cat.id", :conditions => ["date BETWEEN ? AND ? AND cat.name != 'Stipendio'", start_date, end_date])
    else
      if date > today
        return stipendio.to_f
      else
        return stipendio + Expense.total_for_month(date)
      end
    end
  end


 # GOOGLE CHART METHODS #

  # "http://chart.apis.google.com/chart?cht=p&chd=t:129,47,144,31&chs=250x100&chl=Altro|Benza|Cibo|Elettronica&chco=FF0000"


  def Expense.generate_expenses_pie_chart(date)
    category_amounts = Expense.amounts_for_categories(date)
    base_url = "http://chart.apis.google.com/chart?cht=p&chd=t:"
    categories = ""
    category_amounts.each_pair do |category, amount|
      if amount < 0
        base_url += amount.to_f.round.abs.to_s+","
        categories += category+"|"
      end
    end
    # remove last "|"
    categories = categories[0..-2]
    base_url = base_url[0..-2]+"&chs=350x150&chl="+categories+"&chco=FF0000"
    return base_url
  end
  
  def Expense.generate_daily_chart_for(date)
    amounts = Expense.amounts_by_date_for_month(date)
    return "http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:" + amounts + "&chxl=0:|" + daily_labels_for_month_of(date) + "|1:|0|250|500|750|1000&chs=500x150&chds=0,1000"  
  end

end

class Date
  
  def is_in_current_month
    return ((self.year == Date.today.year) && (self.month == Date.today.month))
  end
  
end