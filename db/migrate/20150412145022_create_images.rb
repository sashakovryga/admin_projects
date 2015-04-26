class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_uid
      t.string :image_name
      t.string :imageable_type
      t.integer :imageble_id

      t.timestamps
    end
  end
end
