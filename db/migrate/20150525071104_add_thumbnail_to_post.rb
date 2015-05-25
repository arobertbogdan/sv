class AddThumbnailToPost < ActiveRecord::Migration
  def change
    add_column :posts, :thumbnail, :string
  end
end
