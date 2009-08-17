class RemoveOldCategoryColumnFromExpense < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :category
  end

  def self.down
    add_column :expenses, :category, :string
  end
end
