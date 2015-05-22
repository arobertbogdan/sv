class CreateSubscribes < ActiveRecord::Migration
  def change
    create_table :subscribes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
