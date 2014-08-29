module PostsHelper
  def is_author?
    @post.author == current_user
  end
end
