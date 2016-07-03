class DropTableCardsLabels < ActiveRecord::Migration
  def up
    drop_table :cards_labels
  end

  def down
    create_join_table :cards, :labels do |t|
      t.index [:card_id, :label_id]
      t.index [:label_id, :card_id]
    end
  end
end
