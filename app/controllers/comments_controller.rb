require 'pry'
class CommentsController < ApplicationController

  def new
    @show = Show.find_by(:id => params[:show_id])
    @comment = Comment.new

  end

  def create
    @show = Show.find_by(:id => params[:show_id])
    @comment = @show.comments.build(comment_params[:comment])

      if @comment.save
        redirect_to show_path(@comment.show_id)
      else
        render show_comments_path
      end
  end

  def edit
    @comment = Comment.find_by(:id => params[:id])
    @show = Show.find_by(:id => params[:show_id])
  end

  def update

    @show = Show.find_by(:id => params[:show_id])
    @comment = Comment.find_by(:id => params[:id])
    @comment.update(comment_params[:comment])
    if @comment.save
      redirect_to show_path(@comment.show_id)
    else
      render show_comments_path
    end

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
  def set_comment
    @comment = Comment.find_by(:id => params[:id])
  end

  def comment_params
    params.permit(:show_id, comment: [:title, :body])
  end

end
