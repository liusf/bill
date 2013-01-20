class Event < ActiveRecord::Base
  validates :event_type_id, :presence => true
  validates :group_id, :presence => true
  validates :place_id, :presence => true

	has_many :event_users
	has_many :users, :through => :event_users

	belongs_to :place
	belongs_to :group
	belongs_to :event_type
end
