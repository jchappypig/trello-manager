class RenameTableMembersToMembers < ActiveRecord::Migration
  def change
    rename_table :memebers, :members
  end
end
