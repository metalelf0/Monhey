class Color < ActiveRecord::Base
  validates_uniqueness_of :code
end

class CreateColors < ActiveRecord::Migration
  def change
    create_table "colors" do |c|
      c.string :code
    end


   [ "#62F5C8", "#7F97FF", "#7FCAFF", "#A77FFF", "#CAF562", "#E77FFF", "#F3FF7E", "#FF7FB0", "#FF9C7E", "#FFBD7E", "#FFD77E", "#FFF17E" ].each do |color_code|
     Color.find_or_create_by_code(color_code)
   end

  end
end
