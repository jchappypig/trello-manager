class AddTopLabelToCard < ActiveRecord::Migration
  def change
    add_column :cards, :top_label, :string
  end
end
