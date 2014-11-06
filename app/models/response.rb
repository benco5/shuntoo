class Response < ActiveRecord::Base
  belongs_to :choice
  delegate :question, :to => :choice

  accepts_nested_attributes_for :choice

  validates :pip, :choice_id, presence: true
end
