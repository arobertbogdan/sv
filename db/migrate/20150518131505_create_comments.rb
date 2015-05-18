class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.reference :parent
      t.reference :user
      t.reference :post

      t.timestamps null: false
    end
  end
end
