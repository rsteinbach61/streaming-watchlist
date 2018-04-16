require 'pry'
class SessionsController < ApplicationController

  def new
    @user = User.new
    @session = Session.new
  end


  def create
    binding.pry
    @user = User.find_by(name: params[:user][:name])
    return head(:forbidden) unless @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect_to '/welcome'
  end

  def destroy
    binding.pry
    session.delete("user_id")
    redirect_to root_path
  end

end
