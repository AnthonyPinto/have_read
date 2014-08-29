class SubsController < ApplicationController
  
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
  
  def udpate
    
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def destroy
    
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
end
