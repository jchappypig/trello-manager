class AddSprintIdToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :sprint, index: true, foreign_key: true
  end
end
