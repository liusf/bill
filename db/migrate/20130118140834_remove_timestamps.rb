class RemoveTimestamps < ActiveRecord::Migration
  def self.up
    remove_column :groups, :created_at
    remove_column :groups, :updated_at
    
  end

  def self.down
  end
end
