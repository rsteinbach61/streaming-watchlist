class UsersController < ApplicationController
  def new
  end

  def create
  #binding.pry
    if  params[:user][:password] == params[:user][:password_confirmation]
      @user = User.create(user_params)
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      redirect_to '/signup'
    end
  end

  def create
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
