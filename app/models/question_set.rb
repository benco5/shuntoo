class QuestionSet < ActiveRecord::Base
  has_many :questions, inverse_of: :question_set, dependent: :destroy
  has_many :choices, through: :questions

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| 
   a[:content].blank? }, allow_destroy: true
  
  validates :title, presence: true, uniqueness: true

  def first_question
    questions.first
  end

  # def to_param  # overridden
  #   title
  # end
end
