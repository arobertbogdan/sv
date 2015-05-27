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

  def get_online_readers
    subs = Subscribe.where(:category_id => self.id)
    delay = 180
    counter = 0
    subs.each do |subscribe|
      activity = Activity.find_by(:user_id => subscribe.user_id)
      unless activity.nil?
        if (Time.now - activity.updated_at).abs.to_i <= delay
          counter += 1
        end
      end
    end
    counter
  end

  def self.deliver_subscribe_mail subscribe
    SubscribeMailer.subscribe_on_category(subscribe.user, subscribe.category).deliver_now
  end
  def self.deliver_unsubscribe_mail subscribe
    SubscribeMailer.unsubscribe_on_category(subscribe.user, subscribe.category).deliver_now
  end
end
