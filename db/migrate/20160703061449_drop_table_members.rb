class DropTableMembers < ActiveRecord::Migration
  def up
    drop_table :members
  end

  def down
    create_table :members do |t|
      t.string :full_name
      t.string :trello_identifier

      t.timestamps null: false
    end
  end
end
