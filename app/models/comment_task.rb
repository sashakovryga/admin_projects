class CommentTask < ActiveRecord::Base
  extend Enumerize
  belongs_to :task
  validates :comment, :time, :status, :user, presence: true
  after_create :update_task

  enumerize :status, in: [:verify, :do, :perfomed]

  private

  def update_task
    task.time += time
    task.admin_user = AdminUser.find user
    task.status = status
    task.save
  end
end
