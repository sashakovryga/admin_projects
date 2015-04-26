class Task < ActiveRecord::Base
  extend Enumerize
  belongs_to :project
  has_many :images, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true

  enumerize :kind, in: [:programming, :content, :test, :tz, :production, :design]
  enumerize :status, in: [:verify, :do, :perfomed]
end
