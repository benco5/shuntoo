class User < ActiveRecord::Base
  # Provides accessors for handling as 'user.remember_token'
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :name, length: { maximum: 50 }, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, length: { minimum: 8 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Generates new token and assigns to user, then converts token
  # to digest and saves it to DB.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets the user (undoes remember)
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Boolean comparison of raw token's digest to stored digest
  def authenticated?(remember_token)
    remember_digest.nil? ? false :
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
