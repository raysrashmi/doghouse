class AddColumnStatusToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :status, :string
    add_column :friends, :follow_at, :date
  end
end
