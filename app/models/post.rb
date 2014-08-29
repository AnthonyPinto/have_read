# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  url        :string(255)
#  content    :text
#  sub_id     :integer
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true
  
  
  belongs_to(
    :sub,
    class_name: 'Sub',
    foreign_key: :sub_id,
    primary_key: :id
  )
end