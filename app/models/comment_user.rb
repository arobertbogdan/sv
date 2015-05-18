class CommentUser < ActiveRecord::Base
  has_many :child, class_name: "CommentUser",
           foreign_key: "comment_users_id"

  belongs_to :parent, class_name: "CommentUser"
  belongs_to :user
  belongs_to :post
end
