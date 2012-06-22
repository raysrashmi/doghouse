class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :screen_name
      t.string :name
      t.string :email
      t.string :token
      t.string :secret
      t.timestamps
    end
  end
end
