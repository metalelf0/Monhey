class AddColorIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :color_id, :integer
  end
end
