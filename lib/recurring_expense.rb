class RecurringExpense

  # ActiveModel plumbing to make `form_for` work
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_accessor :user, :amount, :description, :start_date, :end_date, :category_id, :day_of_month

  def initialize args
    args.reverse_merge!(default_args).each_pair { |key, val| self.send("#{key}=", val) }
  end

  def default_args
    { :day_of_month => 1, :start_date => Date.today }
  end

  def create_items
    current_date = first_occurrence
    while current_date <= end_date
      Expense.create!(
        :user => user,
        :description => description,
        :amount => amount,
        :date => current_date,
        :category => user.categories.find(category_id)
      )
      current_date += 1.month
    end
  end

  private

  def first_occurrence
    if start_date.day <= day_of_month
      return Date.new(start_date.year, start_date.month, day_of_month)
    else
      return Date.new(start_date.year, start_date.month, day_of_month) + 1.month
    end
  end
end
