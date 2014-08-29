class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])
    
    if @user
      login!(@user)
      flash[:success] = ["Successfully logged in."]
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def new
    @user = User.new
    render :new
  end
  
  private
  
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
