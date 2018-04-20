class ShowsController < ApplicationController
  def new
    @show = Show.new
    @user = current_user
  end

  def create
    @show = Show.create(show_params)
    redirect_to '/users/welcome'
  end

  def edit
    @show = Show.find_by(params[:id])
  end

  def update
    @show = Show.find_by(params[:id])
    @show.update(show_params)
    redirect_to show_path(@show)
  end

  def show
    @show = Show.find_by(params[:id])
  end

  def destroy
  @show = Show.find_by(params[:id])
  @show.delete
  end

  private
  def show_params
    params.require(:show).permit(:show_title, :watchlist_id)
  end
end
