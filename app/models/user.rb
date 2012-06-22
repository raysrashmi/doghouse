class User < ActiveRecord::Base
  # attr_accessible :title, :body
  @queue  = 'find_followers'
  has_many :friends

  def self.perform(screen_name)
    find_followers(screen_name)
  end

  def find_followers
    ids = Twitter.friend_ids(self.screen_name).ids
    ids = ids.in_groups_of(100)
    f = ids.map{|u| Twitter.users(u)}
    f.flatten!
    friends = self.save_friends_to_db (f)
    friends
  end

  def save_friends_to_db(fr)
    friends = self.friends.only_followings
    unless friends.count >=1
      friends = fr.map do|u|
        f = Friend.new
        f.user_id = self.id
        f.uid = u.id
        f.screen_name = u.screen_name
        f.name = u.name
        f.save!
        f
      end
    end
    friends
  end


  def search_users(term)
    friends.only_followings.where('screen_name like ? or name like ?',"%#{term}%","%#{term}%")
  end



end
