class RemoveTypeFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :type
    add_column :events, :event_type, :string
  end

  def self.down
    add_column :events, :type, :string
    remove_column :events, :event_type
  end
end
