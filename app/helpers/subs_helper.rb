module SubsHelper
  def is_moderator? 
    @sub.moderator == current_user
  end
end
