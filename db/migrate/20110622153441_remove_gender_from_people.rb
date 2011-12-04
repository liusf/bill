class RemoveGenderFromPeople < ActiveRecord::Migration
  def self.up
    remove_column :people, :gender
  end

  def self.down
    add_column :people, :gender, :string
  end
end
