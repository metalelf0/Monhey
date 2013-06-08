class CategoriesPieChart

  GOOGLE_CHART_BASE_URL =  "http://chart.apis.google.com/chart?cht=p&chd=t:"

  attr_accessor :user, :date, :url

  def initialize args
    args.each do |key, value|
      self.send("#{key}=", value)
    end
    @url = generate_url
  end

  def generate_url
    category_amounts = monthly_categories_report
    chart_url = GOOGLE_CHART_BASE_URL
    categories = ""
    category_amounts.each_pair do |category, amount|
      if amount < 0
        chart_url += amount.to_f.round.abs.to_s+","
        categories += URI.encode(category+"|")
      end
    end
    # remove last "|"
    categories = categories.gsub(/%7C$/,"")
    chart_url = chart_url[0..-2]+"&chs=350x150&chl="+categories+"&chco=FF0000"
  end

  def monthly_categories_report
    user.expenses_by_year_and_month(:date => date).group_by { |e| e.category.name }.tap do |expenses_by_category|
      expenses_by_category.each do |category, expenses|
        expenses_by_category[category] = expenses.sum(&:amount)
      end
    end
  end 

end
