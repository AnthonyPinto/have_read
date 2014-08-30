class UsersController < ApplicationController
  def index
    render :index
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      login!(@user)
      flash[:success] = ["Welcome Aboard #{@user.user_name}!"]
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def update
    
  end
  
  private
  
  #DRY this out, group with sessions_controller user_params
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
