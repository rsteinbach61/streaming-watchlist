class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    @user = (User.find_by(id: session[:user_id]) || User.new)
  end

  helper_method :current_user

  def logged_in?
    current_user.id != nil
  end

  helper_method :logged_in?

  def edit_permitted?
    if params[:controller] == 'watchlists'
      watchlist = Watchlist.find(params[:id])
      current_user.id == watchlist.user_id
    elsif params[:controller] == 'shows'
      show = Show.find(params[:id])
      current_user.id == show.watchlist.user_id
    end
  end
  helper_method :edit_permitted?
end
