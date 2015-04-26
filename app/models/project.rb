class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks
  just_define_datetime_picker :to
  just_define_datetime_picker :from
  validates :title, :from, :to, presence: true
end
