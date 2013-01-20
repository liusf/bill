class EventUser < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :pay, :presence => true, :numericality => true
  validates :consume, :presence => true, :numericality => true
  
  belongs_to :event, :autosave => true
  belongs_to :user
end
