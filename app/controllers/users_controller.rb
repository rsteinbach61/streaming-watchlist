require 'pry'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def welcome
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    if  params[:user][:password] == params[:user][:password_confirmation]
      @user = User.create(user_params)
    end
      if @user.save
        session[:user_id] = @user.id
        render '/users/welcome'
      else
        redirect '/users/new'
      end
  end

  def edit
    unless access_permitted?
      redirect_to root_path, notice: 'Access denied'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'User updated.'
    else
      render :edit
    end
  end

  def show
  end



  private

  def set_user
    @user = User.find_by(:id => params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
