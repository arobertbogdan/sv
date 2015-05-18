class Comment < ActiveRecord::Base
  has_many :child, class_name: "Comment",
           foreign_key: "parent_id"

  belongs_to :parent, class_name: "Comment"
  belongs_to :user
  belongs_to :post
end
