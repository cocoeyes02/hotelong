class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :user_id, null: false
      t.string :password, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.integer :tel, null: false
      t.integer :age, null: false
      t.string :email, null: false
      t.boolean :admin_authority, null: false, default: false

      t.timestamps null: false
    end
  end
end
