
class SessionsController < ApplicationController
skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end


  def create
    if auth
      @user = User.find_or_create_by_omniauth(auth)
      session[:user_id] = @user.id
      render '/users/welcome'
    else
      @user = User.find_by(name: params[:user][:name])
        if @user && @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          @watchlists = @user.watchlists
          render '/users/welcome'
        else
          flash[:error] = "Log in failed."
          redirect_to '/sessions/sign_in'
        end
    end
  end

  def destroy
    session.delete("user_id")
    redirect_to root_path, notice: 'Log out successful.'
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
