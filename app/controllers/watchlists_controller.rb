class WatchlistsController < ApplicationController
  def new
    @watchlist = Watchlist.new
    @user = current_user
  end

  def create
    @user = current_user
    @watchlist = @user.watchlists.create(watchlist_params)
    render '/watchlists/show'
  end

  def edit
    #binding.pry
    @watchlist = Watchlist.find(params[:format])
  end

  def show
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:title, :user_id)
  end

end
