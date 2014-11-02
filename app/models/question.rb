class Question < ActiveRecord::Base
  has_many :choices, dependent: :destroy
  has_many :responses, through: :choices
  belongs_to :question_set
  belongs_to :question_format

  accepts_nested_attributes_for :choices,
    :reject_if => lambda { |a| a[:content].blank? }, allow_destroy: true

  accepts_nested_attributes_for :responses,
    :reject_if => lambda { |a| a[:content].blank? }, allow_destroy: true

  validates :content, :question_set, :question_format_id, presence: true  
end
