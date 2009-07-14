class AddDateToExpenses < ActiveRecord::Migration
  def self.up
  	add_column :expenses, :date, :date
  end

  def self.down
  	remove_column :expenses, :date
  end
end
