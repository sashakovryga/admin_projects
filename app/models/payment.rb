class Payment < ActiveRecord::Base
  belongs_to :project

  validates :price, :comment, presence: true
  scope :ordered, -> {order('price DESC')}
end
