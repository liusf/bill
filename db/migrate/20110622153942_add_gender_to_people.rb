class AddGenderToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :gender, :boolean
  end

  def self.down
    remove_column :people, :gender
  end
end
