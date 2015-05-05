class Project < ActiveRecord::Base
  belongs_to :client
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks
  has_many :payments, dependent: :destroy
  accepts_nested_attributes_for :payments
  just_define_datetime_picker :to
  just_define_datetime_picker :from
  validates :title, :from, :to, presence: true

  scope :ordered, -> { order('created_at DESC')}

  def time_percent(start, stop)
    days = (60 * 60 * 24)
    total = (stop - start).to_i / days
    befores = ( ((self.from || start) - start) / days ) / total * 100
    afters = ( (stop - (self.to || stop)) / days ) / total * 100
    length = 100 - befores - afters
    {:total => total, :befores => befores, :afters => afters, :length => length}
  end

  def empty_dates?
    [from, to].reject {|e| e.nil?}.length == 0
  end
end
