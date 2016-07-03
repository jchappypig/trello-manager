class AddLabelsToCard < ActiveRecord::Migration
  def change
    add_column :cards, :labels, :string
  end
end
