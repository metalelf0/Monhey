class AddAccountToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :account_id, :integer
    Expense.all.each { |exp| MigrateUtils.migrate_and_save exp }
    remove_column :expenses, :bancomat
  end

  def self.down
    add_column :expenses, :bancomat, :boolean
    Expense.all.each { |exp| MigrateUtils.migrate_back_and_save exp }
    remove_column :expenses, :account_id
  end
end
