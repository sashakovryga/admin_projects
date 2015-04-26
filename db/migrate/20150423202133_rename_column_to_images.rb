class RenameColumnToImages < ActiveRecord::Migration
  def change
    rename_column :images, :imageble_id, :imageable_id
    add_index :images, :imageable_id
  end
end
