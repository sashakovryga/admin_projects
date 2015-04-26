class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, index: true
      t.string :title
      t.text :description
      t.datetime :time

      t.timestamps
    end
  end
end
