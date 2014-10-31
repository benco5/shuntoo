class Question < ActiveRecord::Base
  belongs_to :question_set
  has_many :choices, dependent: :destroy
  belongs_to :question_format

  accepts_nested_attributes_for :choices,
    :reject_if => lambda { |a| a[:content].blank? }, allow_destroy: true

  validates :content, :question_set, :question_format_id, presence: true  
end
