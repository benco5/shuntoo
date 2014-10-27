class QuestionSet < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :choices, through: :questions
  
  validates :title, presence: true, uniqueness: true
end
