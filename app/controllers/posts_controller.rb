class PostsController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :require_author, only: [:edit, :update]
  
  def new
    @subs = Sub.all
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    # @post = Post.new(post_params)
   #  @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end
end
