class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.integer :apply_count, null: false
      t.integer :price, null: false

      t.timestamps null: false
    end
  end
end
