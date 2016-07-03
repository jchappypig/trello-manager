class DropTableLabels < ActiveRecord::Migration
  def up
    drop_table :labels
  end

  def down
    create_table :labels do |t|
      t.string :name
      t.string :color
      t.string :trello_identifier

      t.timestamps null: false
    end
  end
end
