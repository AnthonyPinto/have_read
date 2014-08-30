# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  commenter_id :integer
#  post_id      :integer
#  content      :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Comment < ActiveRecord::Base
  #validate the associations, not the id
  validates :commenter_id, :post_id, :content, presence: true
  
  belongs_to(
    :commenter,
    class_name: 'User',
    foreign_key: :commenter_id,
    primary_key: :id
  
  )
  
  belongs_to(
    :post,
    class_name: 'Post',
    foreign_key: :post_id,
    primary_key: :id
  )
  
end
