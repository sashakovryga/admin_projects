class ChangeTimeClomn < ActiveRecord::Migration
  def change
    change_column :tasks, :time, :float
  end
end
