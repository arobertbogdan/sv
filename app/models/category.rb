class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :posts
  has_many :subscribes

  def is_subscribed user
    if user == nil
      return false
    end
    Subscribe.where(:user_id => user.id, :category_id => self.id).any?
  end
end
