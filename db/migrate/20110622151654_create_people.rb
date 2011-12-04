class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.string :short
      t.string :mobile
      t.string :email
      t.string :gender

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
