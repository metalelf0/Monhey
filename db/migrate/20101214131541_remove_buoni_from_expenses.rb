class RemoveBuoniFromExpenses < ActiveRecord::Migration
  def self.up
    remove_column :expenses, :buoni
  end

  def self.down
    add_column :expenses, :buoni, :integer
  end
end
