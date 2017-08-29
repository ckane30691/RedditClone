class User < ApplicationRecord
  validates :password_digest, :session_token, :username, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :subs,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :Sub

  attr_reader :password

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username , pw)
    user = User.find_by(username: username)
    return nil unless username
    user.is_password?(pw)
  end

end
