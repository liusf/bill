class Person < ActiveRecord::Base
	validates_uniqueness_of :short
	has_many :memberships
	has_many :groups, :through => :memberships

	has_many :event_people
	has_many :events, :through => :event_people
end
