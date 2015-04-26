class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  dragonfly_accessor :image

  validates :image, :presence => true
end
