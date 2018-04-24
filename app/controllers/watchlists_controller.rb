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
    if edit_permitted?
      @watchlist = Watchlist.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    @watchlist = Watchlist.find(params[:id])
    @watchlist.update(watchlist_params)
    redirect_to root_path
  end

  def show
    @watchlist = Watchlist.find_by(:id => params[:id])
  end

  def index
    binding.pry
    @watchlists = Watchlist.all
  end

  def destroy
  @watchlist = Watchlist.find_by(:id => params[:id])
  @watchlist.delete
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:title, :user_id)
  end

end
