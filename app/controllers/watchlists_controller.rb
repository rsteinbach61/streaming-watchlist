class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: [:show, :edit, :update, :destroy]
  def new
    @watchlist = Watchlist.new
    @user = current_user
  end

  def create
    @user = current_user
    @watchlist = @user.watchlists.create(watchlist_params)
    if @watchlist.save
      redirect_to watchlist_path(@watchlist.id), notice: 'Watchlist created.'
    else
      render new_watchlist_path
    end
  end

  def edit
    # helper to check if current user can edit this watchlist
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied.'
    end
  end

  def update
    # helper to check if current user can update this watchlist
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied.'
    else
      @watchlist.update(watchlist_params)
      redirect_to root_path, notice: 'Watchlist successfully updated.'
    end
  end

  def show
    # helper to check if current user can view this watchlist
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied.'
    else
      @shows = @watchlist.shows
    end
  end

  def index
    @user = current_user
    @watchlists = @user.watchlists
  end

  def destroy
    # helper to check if current user can delete this watchlist
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied.'
    else
      @watchlist.destroy
      redirect_to root_path, notice: 'Watch list deleted.'
    end
  end

  private

  def set_watchlist
    @watchlist = Watchlist.find_by(:id => params[:id])
  end

  def watchlist_params
    params.require(:watchlist).permit(:title, :user_id)
  end

end
