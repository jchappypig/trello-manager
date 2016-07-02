class AddEstimatedSizeToCard < ActiveRecord::Migration
  def change
    add_column :cards, :estimated_size, :integer
  end
end
