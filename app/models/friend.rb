class Friend < ActiveRecord::Base
  #attr_accessible :name, :screen_name, :uid
  belongs_to :user
  scope :only_followings, where('status is NULL')
  scope :unfollowed,where("status = 'unfollowed'")
  scope :exit_at_doghouse,where("follow_at=?",Date.today)

  def self.follow_again
    unfollowed.group_by(&:user_id).each do|k,v|
      u  = User.find(k)
      t = Twitter::Client.new({:oauth_token => u.token, :oauth_token_secret => u.secret})
      v.each do |f|
        if t.follow(f.screen_name)
          Rails.logger.debug "=============#{f.destroy}"
        end
      end

    end
  end
end
