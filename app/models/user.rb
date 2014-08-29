# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)
#  password_digest :string(255)
#  session_token   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password
  
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  
  after_initialize :ensure_session_token
  
  has_many(
    :moderated_subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  has_many(
    :authored_posts,
    class_name: "Post",
    foreign_key: :moderator_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return user if (user && user.is_password?(password))
    nil
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
