class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.string :description
      t.float :amount
      t.string :category
      t.boolean :bancomat
      t.boolean :ufficio
      t.integer :buoni

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
