class ChangeEvent2 < ActiveRecord::Migration
  def self.up
	  remove_column :events, :event_type
	  add_column :events, :event_type_id, :integer
  end

  def self.down
	  remove_column :events, :event_type_id
	  add_column :events, :event_type, :string
  end
end
