class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :screen_name
      t.string :name
      t.string :uid
      t.integer :user_id

      t.timestamps
    end
  end
end
