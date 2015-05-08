class AddUserToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :admin_user_id, :integer
    add_index :tasks, :admin_user_id
  end
end
