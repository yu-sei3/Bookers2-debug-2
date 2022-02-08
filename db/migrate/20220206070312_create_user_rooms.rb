class CreateUserRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_rooms do |t|
      t.references :user, index: true, foreign_key: true
      t.references :room, index: true, foreign_key: true

      t.timestamps
    end
  end
end
