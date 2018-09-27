require 'pry'
class CommentsController < ApplicationController
skip_before_action :require_login
  def new
    @show = Show.find_by(:id => params[:show_id])
    @comment = Comment.new

  end

    def create

      @show = Show.find_by(:id => params[:show_id])
      @comment = @show.comments.build(comment_params[:comment])
      @comment.save
      @comments = @show.comments # I didn't do this
        respond_to do |format|
          format.html {render "/comments/index"}
          format.json {render json: @comments.to_json(only: [:title, :body, :id])}
        end
    end

  def edit
    #use the access_permitted helper to determine if the current user can edit this comment
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    else
      @comment = Comment.find_by(:id => params[:id])
      @show = Show.find_by(:id => params[:show_id])
    end
  end

  def update
    #use the access_permitted helper to determine if the current user can edit this comment
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    else
      @show = Show.find_by(:id => params[:show_id])
      @comment = Comment.find_by(:id => params[:id])
      @comment.update(comment_params[:comment])
      if @comment.save
        redirect_to show_path(@comment.show_id)
      else
        render show_comments_path
      end
    end

  end

  def show
    #use the access_permitted helper to determine if the current user can edit this comment
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    else
      @comment = Comment.find_by(:id => params[:id])
        respond_to do |format|
          format.html {render "/comments/show"}
          format.json {render json: @comment.to_json(only: [:title, :body, :id])}
        end

    end
  end

  def index
    if logged_in?
      @show = Show.find_by(:id => params[:show_id])
      @comments = @show.comments
      respond_to do |format|
        format.html {render "/comments/index"}
        format.json {render json: @comments.to_json(only: [:title, :body, :id])}
      end
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
