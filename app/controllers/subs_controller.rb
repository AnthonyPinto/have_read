class SubsController < ApplicationController
  
  before_action :require_login, except: [:show, :index]
  before_action :require_moderator, only: [:edit, :update, :destroy]
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def show
    @sub = Sub.find(params[:id])
  end
  
  def index
    
  end
  
  def new
    @sub = Sub.new
    render :new
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
end
