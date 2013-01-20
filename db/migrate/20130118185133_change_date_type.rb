class ChangeDateType < ActiveRecord::Migration
  def self.up
    change_column :events, :date, :date
  end

  def self.down
  end
end
