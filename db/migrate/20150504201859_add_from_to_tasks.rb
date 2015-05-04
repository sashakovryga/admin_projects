class AddFromToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :to, :datetime
    add_column :tasks, :from, :datetime
  end
end
