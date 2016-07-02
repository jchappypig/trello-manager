class AddTrelloIdentifierToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :trello_identifier, :string
  end
end
