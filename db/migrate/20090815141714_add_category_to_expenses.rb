class AddCategoryToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :category_id, :integer
  end

  def self.down
    remove_column :expenses, :category_id
  end
end
