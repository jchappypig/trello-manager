class AddMembersToCard < ActiveRecord::Migration
  def change
    add_column :cards, :members, :string
  end
end
