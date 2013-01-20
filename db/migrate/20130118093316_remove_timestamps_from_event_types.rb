class RemoveTimestampsFromEventTypes < ActiveRecord::Migration
  def self.up
    remove_column :event_types, :created_at
    remove_column :event_types, :updated_at
    remove_column :users, :created_at
    remove_column :users, :updated_at
    remove_column :places, :created_at
    remove_column :places, :updated_at
  end

  def self.down
    add_column :event_types, :updated_at, :datetime
    add_column :event_types, :created_at, :datetime
    add_column :users, :updated_at, :datetime
    add_column :users, :created_at, :datetime
    add_column :places, :updated_at, :datetime
    add_column :places, :created_at, :datetime
  end
end
