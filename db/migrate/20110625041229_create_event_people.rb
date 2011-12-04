class CreateEventPeople < ActiveRecord::Migration
  def self.up
    create_table :event_people do |t|
      t.integer :event_id
      t.integer :person_id
      t.integer :consume
      t.integer :contribute

      t.timestamps
    end
  end

  def self.down
    drop_table :event_people
  end
end
