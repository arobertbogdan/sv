require 'securerandom'
class User < ActiveRecord::Base
  before_create :set_auth_token

  validates :nickname, presence: true
  has_attached_file :avatar, :styles => { :medium => "150x150>", :thumb => "20x20>" }, :default_url => "missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :activity

  has_many :post_votes
  has_many :posts
  has_many :comments
  has_many :follows
  has_many :subscribes

  def is_following user
    Follow.where(:user_id => id, :follow_id => user.id).any?
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end
end
