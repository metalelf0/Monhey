class CategoriesPieChart

  attr_accessor :user, :date, :chart

  def initialize args
    args.each do |key, value|
      self.send("#{key}=", value)
    end
    @chart = pie_chart
  end

  def pie_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Category')
    data_table.new_column('number', 'Amount')
    data_table.add_rows(monthly_categories_report.size)
    count = 0
    colors = []
    monthly_categories_report.each_pair do |category, amount_and_color|
      data_table.set_cell(count, 0, category)
      data_table.set_cell(count, 1, amount_and_color[:amount].abs)
      colors << amount_and_color[:color]
      count += 1
    end

    opts   = { :width => 400, 
               :height => 240, 
               :is3D => false,
               :colors => colors,
               :pieSliceText => "none"
    }
    GoogleVisualr::Interactive::PieChart.new(data_table, opts)
  end

  def monthly_categories_report
    report = {}
    user.expenses_by_year_and_month(:date => date).group_by { |e| e.category }.tap do |expenses_by_category|
      expenses_by_category.each do |category, expenses|
        category_total = expenses.sum { |expense| expense.amount < 0 ? expense.amount : 0 } 
        report[category.name] = { 
          :amount => category_total,
          :color => category.color_code
        }
      end
    end
    report
  end 

end
