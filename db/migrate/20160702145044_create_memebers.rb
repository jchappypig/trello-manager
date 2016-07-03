class CreateMemebers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :full_name
      t.string :trello_identifier

      t.timestamps null: false
    end
  end
end
