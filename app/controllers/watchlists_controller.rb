class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: [:show, :edit, :update, :destroy]
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
    @watchlist.update(watchlist_params)
    redirect_to root_path, notice: 'Watchlist successfully updated.'
  end

  def show

  end

  def index
    binding.pry
    @watchlists = Watchlist.all
  end

  def destroy

    @watchlist.destroy
    redirect_to root_path, notice: 'Watch list deleted.'
  end

  private

  def set_watchlist
    @watchlist = Watchlist.find_by(:id => params[:id])
  end

  def watchlist_params
    params.require(:watchlist).permit(:title, :user_id)
  end

end
