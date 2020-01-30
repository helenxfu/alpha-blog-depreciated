class SessionsController < ApplicationController
  def new
  end

  def create
    # debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "welcome back"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Oops, something wrong with login info"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "See you next time!"
    redirect_to root_path
  end
end
