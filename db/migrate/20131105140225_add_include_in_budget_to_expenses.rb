class AddIncludeInBudgetToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :include_in_budget, :boolean, :default => true
  end
end
