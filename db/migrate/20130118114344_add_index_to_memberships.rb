class AddIndexToMemberships < ActiveRecord::Migration
  def self.up
    add_index(:memberships, [:user_id, :group_id], :unique => true)
  end

  def self.down

  end
end
