class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :memberships
  has_many :groups, :through => :memberships
  
  has_many :event_users
  has_many :events, :through => :event_users
end
