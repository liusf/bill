class ChangeEventPeople < ActiveRecord::Migration
  def self.up
	  remove_column :event_people, :contribute
	  add_column :event_people, :pay, :integer
  end

  def self.down
	  remove_column :event_people, :pay
	  add_column :event_people, :contribute, :integer
  end
end
