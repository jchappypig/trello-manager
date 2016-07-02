class RenameEndToFinishInSprints < ActiveRecord::Migration
  def change
    rename_column :sprints, :end, :finish
  end
end
