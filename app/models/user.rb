class User < ActiveRecord::Base
  
  attr_reader :password
  
  validates :username, :session_token, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  before_validation :ensure_session_token
  
  has_many :subs
  has_many :posts
  
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
  
  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end
  
  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def password=(password)
    return unless password.present?
    
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
   BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)
    return nil if @user.nil?
    @user.is_password?(password) ? @user : nil
  end
  
end
