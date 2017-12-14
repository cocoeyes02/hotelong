class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.integer :person_price, null: false
      t.string :style_name, null: false
      t.integer :expect_count, null: false
      t.integer :can_add_bed, null: false
      t.float :discount_rate, null: false, default: 1.0
      t.float :surcharge_rate, null: false, default: 1.0

      t.timestamps null: false
    end
  end
end
