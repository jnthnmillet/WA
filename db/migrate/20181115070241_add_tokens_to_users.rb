class AddTokensToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token_type, :string
    add_column :users, :access_token, :string
  end
end
