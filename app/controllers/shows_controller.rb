class ShowsController < ApplicationController
  before_action :set_show#, only: [:show, :edit, :update, :destroy]
  def new
    @show = Show.new
    @user = current_user
  end

  def create
    @user = current_user
    @show = Show.create(show_params)
    redirect_to root_path, notice: 'Show created.'
  end

  def edit
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    end
  end

  def update
    if @show.update(show_params)
      redirect_to show_path(@show), notice: 'Show updated.'
    else
      render :edit
    end
  end

  def show
    @comments = @show.comments
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    end
  end

  def destroy
    @show.destroy
    redirect_to root_path, notice: 'Show deleted.'
  end

  def search
    @user = current_user
  end

  def results
    genre = params[:genres]
    type = params[:type]
    @shows = []
    Show.genre(genre).show_type(type).each do |show|
      if show.watchlist.user_id == current_user.id
        @shows << show
      end
    end
      if @shows.empty?
        redirect_to shows_search_path, notice: 'Show not found.'
      else
        render '/shows/results'
      end
  end

  private
  def set_show
    @show = Show.find_by(:id => params[:id])
  end

  def show_params
    params.require(:show).permit(:show_title, :watchlist_id, :show_type, :genre)
  end
end
