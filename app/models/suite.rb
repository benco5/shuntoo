class Suite < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true


  has_many :questions, dependent: :destroy 

end
