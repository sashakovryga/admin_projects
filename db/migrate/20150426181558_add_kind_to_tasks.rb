class AddKindToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :kind, :string
  end
end
