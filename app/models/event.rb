class Event < ActiveRecord::Base
	has_many :event_people
	has_many :people, :through => :event_people

	belongs_to :place
	belongs_to :group
	belongs_to :event_type
end
