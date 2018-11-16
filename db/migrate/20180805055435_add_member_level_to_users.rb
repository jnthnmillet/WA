class AddMemberLevelToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :member_level, :integer, default: 0, null: false
  end
end
