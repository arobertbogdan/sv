class Follow < ActiveRecord::Base

  belongs_to :user

  def self.get_user_followings user
    follows = Follow.where(:user_id => user).joins("INNER JOIN users ON users.id = follows.follow_id").select('follows.*','users.*')
  end
end
