class Changetimecoluntasks < ActiveRecord::Migration
  def change
    change_column :tasks, :time, :float, default: 0.0
  end
end
