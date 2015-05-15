class CreateCommentTasks < ActiveRecord::Migration
  def change
    create_table :comment_tasks do |t|
      t.text :comment
      t.float :time, default: 0.0
      t.string :status
      t.references :task, index: true
      t.string :user

      t.timestamps
    end
  end
end
