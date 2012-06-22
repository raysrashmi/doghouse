module ApplicationHelper

  def current_user
    session[:current_user]
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

end
