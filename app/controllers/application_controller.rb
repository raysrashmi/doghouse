class ApplicationController < ActionController::Base
  #before_filter :authenticate_user!
  include ApplicationHelper
  private

  def authenticate_user!
     return  !current_user
  end

  #protect_from_forgery
end
