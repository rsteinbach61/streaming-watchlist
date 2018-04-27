
class SessionsController < ApplicationController
skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end


  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      render '/users/welcome'
    else
      flash[:error] = "Log in failed."
      redirect_to '/sessions/sign_in'
    end
  end

  def destroy
    session.delete("user_id")
    redirect_to root_path, notice: 'Log out successful.'
  end

end
