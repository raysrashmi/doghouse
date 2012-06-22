class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    omniauth = env["omniauth.auth"]
    p"***********"
    p omniauth['credentials']
    authentication = User.find_by_uid(omniauth['uid'])
    p authentication
    if authentication
      flash[:notice] = "Signed in successful."
    else
      authentication = User.new()
      authentication.uid = omniauth['uid']
      authentication.screen_name = omniauth['info'].nickname
      authentication.name = omniauth['info'].name
      authentication.token = omniauth['credentials']['token']
      authentication.secret = omniauth['credentials']['secret']
      authentication.save!
      flash[:notice] = "Authentication successful."
    end
    session[:current_user] = authentication
    redirect_to users_path
  end

  def destroy
    current_user.friends.only_followings.destroy_all
    session[:current_user] = nil
    flash[:notice] = "Logout Successfully"
    redirect_to root_path
  end
end
