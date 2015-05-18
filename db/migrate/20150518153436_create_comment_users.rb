class CreateCommentUsers < ActiveRecord::Migration
  def change
    create_table :comment_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.references :comment_user, index: true, foreign_key: true
      t.string :content

      t.timestamps null: false
    end
  end
end
