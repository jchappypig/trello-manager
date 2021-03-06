class DropTableCardsMembers < ActiveRecord::Migration
  def up
    drop_table :cards_members
  end

  def down
    create_join_table :cards, :members do |t|
      t.index [:card_id, :member_id]
      t.index [:member_id, :card_id]
    end
  end
end
