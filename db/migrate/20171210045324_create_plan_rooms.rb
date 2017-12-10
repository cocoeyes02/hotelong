class CreatePlanRooms < ActiveRecord::Migration
  def change
    create_table :plan_rooms do |t|

      t.timestamps null: false
    end
  end
end
