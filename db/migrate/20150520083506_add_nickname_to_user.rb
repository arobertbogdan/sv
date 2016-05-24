class AddNicknameToUser < ActiveRecord::Migration
  def up
    add_column :users, :nickname, :string, default: ""
    change_column_null :users, :nickname, false
    add_column :users, :auth_token, :string
    change_column_null :users, :auth_token, false
  end
  def down
    remove_column :users, :nickname, :string
    remove_column :users, :auth_token, :string
  end
end
