class Response < ActiveRecord::Base
  belongs_to :choice
  delegate :question, :to => :choice

  validates :pip, presence: true
end
