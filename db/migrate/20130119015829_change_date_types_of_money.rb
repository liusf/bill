class ChangeDateTypesOfMoney < ActiveRecord::Migration
  def self.up
    change_column :event_users, :pay, :decimal, :precision => 8, :scale => 2
    change_column :event_users, :consume, :decimal, :precision => 8, :scale => 2
  end

  def self.down
  end
end
