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
  #validate the association!
  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true
  
  has_many(
    :post_subs,
    class_name: 'PostSub',
    foreign_key: :sub_id,
    primary_key: :id,
    dependent: :destroy,
    inverse_of: :sub
  )
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )
  
end
