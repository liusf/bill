class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :place_id
      t.datetime :date
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
