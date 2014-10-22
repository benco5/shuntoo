class QuestionSet < ActiveRecord::Base
  has_many :questions
  
  validates :title, presence: true, uniqueness: true
end
