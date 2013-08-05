class Category < ActiveRecord::Base
  attr_accessible :color_code, :name, :user

  MONTHS = "1|2|3|4|5|6|7|8|9|10|11|12"

  belongs_to :user
  belongs_to :color
  has_many :expenses
  validates_presence_of :name
  validates_presence_of :user

  def totals_for_year(year)
    totals = []
    1.upto(12) do |month|
      totals << user.total_for_month_by_category(:date => Date.new(year, month, 1), :category_name => self.name )
    end
    totals
  end

  def google_chart_for_year year
    totals = totals_for_year year
    return "http://chart.apis.google.com/chart?cht=lc&chxt=x,y&chg=0,25&chd=t:" + totals.join(',') + "&chxl=0:|" + MONTHS + "|1:|0|250|500|750|1000&chs=500x150&chds=0,1000"
  end

  def color_code
    color.try(:code) || "#111"
  end

  def color_code= color_code
    self.color = Color.find_by_code(color_code)
  end

end
