class Task < ActiveRecord::Base
  extend Enumerize
  belongs_to :project
  belongs_to :admin_user
  has_many :images, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true
  has_many :comment_tasks, dependent: :destroy
  accepts_nested_attributes_for :comment_tasks

  just_define_datetime_picker :to
  just_define_datetime_picker :from
  enumerize :kind, in: [:programming, :content, :test, :tz, :production, :design]
  enumerize :status, in: [:verify, :do, :perfomed]
  scope :ordered, -> {order('tasks.from ASC')}
  scope :ordered_to, -> {order('tasks.to ASC')}

  def time_percent(start, stop, kind, status, user = nil)
    stat = status.to_sym == :all ? Task.status.values : status.split
    prev = if user.nil?
      Task.where('tasks.from < ? AND kind = ? AND status IN (?)', self.from, kind, stat).ordered_to.last
    else
      user.tasks.where('tasks.from < ? AND kind = ? AND status IN (?)', self.from, kind, stat).ordered_to.last
    end
    minus = prev.nil? ? start : prev.to
    days = (60 * 60 * 24)
    total = (stop - start).to_i / days
    befores = ( ((self.from || start) - minus) / days ) / total * 100
    befores_prev = ( ((self.from || start) - start) / days ) / total * 100
    afters = ( (stop - (self.to || stop)) / days ) / total  * 100
    length = 100 - afters - (prev.nil? ? befores : befores_prev)
    {:total => total, :befores => befores, :afters => afters, :length => length}
  end

  def empty_dates?
    [from, to].reject {|e| e.nil?}.length == 0
  end

  def next(user = nil, kind = nil)
    # if user.nil?
    #   self.class.unscoped.ordered.where("tasks.to >= ? AND id != ?", to, id).order("tasks.to DESC").first
    # else
    self.class.unscoped.ordered.where("tasks.to >= ? AND id != ? AND admin_user_id = ? AND kind = ?", to, id, user, kind).order("tasks.to DESC").first
    # end
  end

  def previous(user = nil, kind = nil)
    # if user.nil?
    #   self.class.unscoped.ordered.where("tasks.from <= ? AND id != ?", from, id).order("tasks.from ASC").first
    # else
      self.class.unscoped.ordered.where("tasks.from <= ? AND id != ? AND admin_user_id = ? AND kind = ?", from, id, user, kind).order("tasks.from ASC").last
    # end
  end
end
