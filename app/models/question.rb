class Question < ActiveRecord::Base
  has_many :choices, dependent: :destroy
  has_many :responses, through: :choices
  belongs_to :question_set
  belongs_to :question_format

  accepts_nested_attributes_for :choices,
    :reject_if => lambda { |a| a[:content].blank? }, allow_destroy: true

  accepts_nested_attributes_for :responses

  validates :content, :question_set, :question_format_id, presence: true  

  self.per_page = 1 # Sets number of questions / pagination page to 1

  def previous
    Question.where(["id < ?", id]).last
  end

  def next
    Question.where(["id > ?", id]).first
  end
end
