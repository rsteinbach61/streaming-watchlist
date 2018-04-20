require 'pry'
class UsersController < ApplicationController
  def welcome
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
  #binding.pry
    if  params[:user][:password] == params[:user][:password_confirmation]
      @user = User.create(user_params)
    end
      if @user.save
        session[:user_id] = @user.id
        redirect_to '/users/welcome'
      else
        render '/users/new'
      end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
