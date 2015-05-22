class User < ActiveRecord::Base
  validates :nickname, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :post_votes
  has_many :posts
  has_many :comments
  has_many :follows
  has_many :subscribes
end
