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
    if edit_permitted?
      @show = Show.find_by(:id => params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    @show = Show.find_by(:id => params[:id])
    @show.update(show_params)
    redirect_to show_path(@show)
  end

  def show
    @show = Show.find_by(:id => params[:id])
  end

  def destroy
  @show = Show.find_by(:id => params[:id])
  @show.delete
  end

  private
  def show_params
    params.require(:show).permit(:show_title, :watchlist_id)
  end
end
