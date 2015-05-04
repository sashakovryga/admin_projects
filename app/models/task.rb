class Task < ActiveRecord::Base
  extend Enumerize
  belongs_to :project
  has_many :images, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true

  just_define_datetime_picker :to
  just_define_datetime_picker :from
  enumerize :kind, in: [:programming, :content, :test, :tz, :production, :design]
  enumerize :status, in: [:verify, :do, :perfomed]

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
