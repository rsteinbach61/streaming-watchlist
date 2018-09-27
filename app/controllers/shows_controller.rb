class ShowsController < ApplicationController
  before_action :set_show#, only: [:show, :edit, :update, :destroy]
  def new
    @show = Show.new
    @user = current_user
  end

  def create
    @user = current_user
    @show = Show.create(show_params)
    if @show.save
      redirect_to root_path, notice: 'Show created.'
    else
      render new_show_path
    end
  end

  def edit
    #use the access_permitted helper to determine if the current user can edit this show
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    end
  end

  def update
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    else
      if @show.update(show_params)
        redirect_to show_path(@show), notice: 'Show updated.'
      else
        render :edit
      end
    end
  end

  def show
    # helper method in application controller to check if current_user owns the show requested
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    else
      @comments = @show.comments
      # create new show_details class object (details) using the title and type of @show
      details = Details.new(@show.show_title, @show.show_type)
      # use that details object to call the get_details method and return results to @details for use in shows/show view
      @details = details.get_details
    end
    respond_to do |format|
      format.html {render "/shows/show"}
      format.json {render json: @show.to_json}
    end
  end

  def index
    @shows = current_user.shows
  end


  def destroy
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    else
      @show.destroy
      redirect_to root_path, notice: 'Show deleted.'
    end
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
