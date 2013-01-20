class Group < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  has_many :memberships
	has_many :users, :through => :memberships
  has_many :events  

  def summary(user_id)
    res = EventUser.joins(:event).where('events.group_id' => id, 'event_users.user_id' => user_id).select('SUM(event_users.pay) as pay, SUM(event_users.consume) AS consume');
    if res.length >= 1 && res[0].pay && res[0].consume
      res[0].pay - res[0].consume
    else
      0
    end
#    conn = connection()
#    res = conn.select('SELECT SUM(event_users.pay) as total_pay, SUM(event_users.consume) AS total_consume FROM event_users INNER JOIN events ON events.id = event_users.event_id WHERE events.group_id = ? AND event_users.user_id = ?', [id, user_id])
#    puts res
  end
end
