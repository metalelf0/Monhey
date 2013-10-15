class RecurringExpense

  # ActiveModel plumbing to make `form_for` work
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_accessor :user, :amount, :description, :end_date, :category_id

  def initialize args
    args.each_pair { |key, val| self.send("#{key}=", val) }
  end

  def create_items
    start_date = Date.today.beginning_of_month
    current_date = start_date
    while current_date <= end_date
      expense = Expense.create!(
        :user => user,
        :description => description,
        :amount => amount,
        :date => current_date,
        :category => user.categories.find(category_id)
      )
      current_date += 1.month
    end
  end
end
