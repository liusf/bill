class DropGroups < ActiveRecord::Migration
  def self.up
    drop_table :groups
    drop_table :memberships
  end

  def self.down
    
  end
end
