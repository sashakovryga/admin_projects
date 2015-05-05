class Client < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  accepts_nested_attributes_for :projects

  validates :title, :description, presence: true
end
