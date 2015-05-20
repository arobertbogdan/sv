class AddNicknameToUser < ActiveRecord::Migration
  def up
    add_column :users, :nickname, :string, default: ""
    change_column_null :users, :nickname, false
  end
  def down
    remove_column :users, :nickname, :string
  end
end
