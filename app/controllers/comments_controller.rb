require 'pry'
class CommentsController < ApplicationController

  def new

    @show = Show.find_by(:id => params[:show_id])
    @comment = Comment.new
    render 'form'
  end

  def create

  @comment = Comment.create(comment_params)
  redirect_to show_path(@comment.show_id)
  end

  def edit
  end

  def update
  end

  def show
    @comment = Comment.find_by(:id => params[:id])
  end

  def index

    if logged_in?
      @show = Show.find_by(:id => params[:show_id])
      @comments = @show.comments
    end
  end

  private
  def set_show
    @show = Show.find_by(:id => params[:id])
  end

  def comment_params
    params.permit(:title, :body, :show_id)
  end

end
