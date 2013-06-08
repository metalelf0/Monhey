class CategoriesCloudChart

  #TODO: config?
  MAX_CLOUD_SIZE = 32
  MIN_CLOUD_SIZE = 12

  attr_accessor :user, :date, :data_hash

  def initialize args
    args.each do |key, value|
      self.send("#{key}=", value)
    end
    @data_hash = generate_hash
  end

  def generate_hash
    hash = {} 
    report = monthly_categories_report
    lowest  = report.values.min
    highest = report.values.max

    report.each_pair do |category, total|
      hash[category] = {}
      hash[category][:style] = font_size_for_tag_cloud(total, lowest, highest)
      hash[category][:amount] = total
    end
    return hash
  end

  def monthly_categories_report
    user.expenses_by_year_and_month(:date => date).group_by { |e| e.category.name }.tap do |expenses_by_category|
      expenses_by_category.each do |category, expenses|
        expenses_by_category[category] = expenses.sum(&:amount)
      end
    end
  end 

  private

  # TODO: helper?
  def font_size_for_tag_cloud(total, lowest, highest)
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
end
