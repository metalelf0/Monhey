class AddAccountToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :account_id, :integer
  end

  def self.down
    remove_column :expenses, :account_id
  end
end
