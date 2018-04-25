class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]
  def new
    @show = Show.new
    @user = current_user
  end

  def create
    @show = Show.create(show_params)
    redirect_to '/users/welcome', notice: 'Show created.'
  end

  def edit
    if edit_permitted?
      @show = Show.find_by(:id => params[:id])
    else
      redirect_to root_path
    end
  end

  def update

    @show.update(show_params)
    redirect_to show_path(@show), notice: 'Show updated.'
  end

  def show
    unless edit_permitted?
      redirect_to root_path, notice: 'Access denied'
    end
  end

  def destroy
    @show.destroy
    redirect_to root_path, notice: 'Show deleted.'
  end

  private
  def set_show
    @show = Show.find_by(:id => params[:id])
  end

  def show_params
    params.require(:show).permit(:show_title, :watchlist_id)
  end
end
