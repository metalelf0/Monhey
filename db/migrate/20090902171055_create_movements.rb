class CreateMovements < ActiveRecord::Migration
  def self.up
    create_table :movements do |t|
      t.integer :from_account_id
      t.integer :to_account_id
      t.date :date
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :movements
  end
end
