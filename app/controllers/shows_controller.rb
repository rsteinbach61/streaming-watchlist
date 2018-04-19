class ShowsController < ApplicationController
  def new
    @show = Show.new
    @user = current_user
  end

  def create
    @show = Show.find_by(params[:id])
  end

  def edit
    @show = Show.find_by(params[:id])
  end

  def update
    @show = Show.find_by(params[:id])
    @show.update(show_params)
  end

  def show
    @show = Show.find_by(params[:id])
  end

  def destroy
  end

  private
  def show_params
    params.require(:show).permit(:show_title)
  end
end
