class RemoveUfficioFromExpenses < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :ufficio
  end

  def self.down
    add_column :expenses, :ufficio, :boolean
  end
end
