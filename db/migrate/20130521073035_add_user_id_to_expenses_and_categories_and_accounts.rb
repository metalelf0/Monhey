class AddUserIdToExpensesAndCategoriesAndAccounts < ActiveRecord::Migration
  def change
      add_column :expenses,   :user_id, :integer
      add_column :categories, :user_id, :integer
      add_column :accounts,   :user_id, :integer
      add_index :expenses, :user_id
      add_index :categories, :user_id
      add_index :accounts, :user_id
  end

end
