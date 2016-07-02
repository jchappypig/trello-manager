class AddTypeToCards < ActiveRecord::Migration
  def change
    add_column :cards, :type, :string
  end
end
