# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  description  :string(255)      not null
#  moderator_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true
  
  has_many(
    :posts,
    class_name: 'Post',
    foreign_key: :sub_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
end
