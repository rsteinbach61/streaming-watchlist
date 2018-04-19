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
    @watchlist = Watchlist.find(params[:id])
  end

  def update
    @watchlist = Watchlist.find(params[:id])
    @watchlist.update(watchlist_params)
  end

  def show
    @watchlist = Watchlist.find_by(:id => params[:id])
  end

  def index
    binding.pry
    @watchlists = Watchlist.all
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:title, :user_id)
  end

end
