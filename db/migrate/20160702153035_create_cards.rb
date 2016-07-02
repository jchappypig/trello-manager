class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :list
      t.string :url
      t.string :trello_identifier

      t.timestamps null: false
    end
  end
end
