class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :price
      t.text :comment
      t.references :project, index: true

      t.timestamps
    end
  end
end
