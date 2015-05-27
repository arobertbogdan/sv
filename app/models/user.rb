class User < ActiveRecord::Base
  validates :nickname, presence: true
  has_attached_file :avatar, :styles => { :medium => "150x150>", :thumb => "20x20>" }, :default_url => "missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :post_votes
  has_many :posts
  has_many :comments
  has_many :follows
  has_many :subscribes

  def is_following user
    Follow.where(:user_id => id, :follow_id => user.id).any?
  end
end
