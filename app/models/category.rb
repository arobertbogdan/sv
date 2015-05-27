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

  def get_readers
    Subscribe.where(:category_id => self.id).count
  end

  def self.deliver_subscribe_mail subscribe
    SubscribeMailer.subscribe_on_category(subscribe.user, subscribe.category).deliver_now
  end
  def self.deliver_unsubscribe_mail subscribe
    SubscribeMailer.unsubscribe_on_category(subscribe.user, subscribe.category).deliver_now
  end
end
