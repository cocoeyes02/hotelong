class CreatePlanRooms < ActiveRecord::Migration
  def change
    create_table :plan_rooms do |t|
      t.references :room, null: false
      t.references :plan, null: false

      t.timestamps null: false
    end
  end
end
