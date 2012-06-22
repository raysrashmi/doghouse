class UsersController < ApplicationController
  before_filter :find_user
  def index

    if current_user
      #@followers = Resque.enqueue(User,current_user.screen_name)
      #have to cache followers
      if params[:term]
        @friends = @user.search_users(params[:term],).paginate(:page => params[:page], :per_page => 50)
      else
        @friends = @user.find_followers.paginate(:page => params[:page], :per_page => 50)
      end

      respond_to  do |format|
        format.js do
        end
        format.html
      end
    end
  end

  def unfollow_friends
    params['followers'].each do |f|
      unfriend = @user.friends.only_followings.find_by_screen_name(f)
      if unfriend
        Twitter.unfollow(f)
        unfriend.status = 'unfollowed'
        unfriend.follow_at = params[:follow_at]
        unfriend.save!
      end
    end
    redirect_to users_path(params[:term])
  end

  private

  def find_user
    @user  = User.find(current_user.id)
  end


end
