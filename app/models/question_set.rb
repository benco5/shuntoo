class QuestionSet < ActiveRecord::Base
  attr_accessor :response_token
  belongs_to :user
  has_many :questions, inverse_of: :question_set, dependent: :destroy
  has_many :choices, through: :questions

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| 
   a[:content].blank? }, allow_destroy: true
  
  validates :title, presence: true, uniqueness: true

  def first_question
    questions.first
  end

  def QuestionSet.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def QuestionSet.new_token
    SecureRandom.urlsafe_base64(6)
  end

  # Generates new token and assigns to user, then converts token
  # to digest and saves it to DB.
  def remember
    self.response_token = QuestionSet.new_token
    update_attribute(:response_digest, QuestionSet.digest(response_token))
  end

    # Boolean comparison of raw token (..converted to digest) to stored digest
  def authenticated?(response_token)
    response_digest.nil? ? false :
      BCrypt::Password.new(response_digest).is_password?(response_token)
  end
end
