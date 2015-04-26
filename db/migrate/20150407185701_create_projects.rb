class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
