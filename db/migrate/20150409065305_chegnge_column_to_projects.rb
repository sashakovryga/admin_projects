class ChegngeColumnToProjects < ActiveRecord::Migration
  def change
    change_column :projects, :to, :datetime
    change_column :projects, :from, :datetime
  end
end
