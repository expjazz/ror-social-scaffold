class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :requests_sent, class_name: 'Friendship', foreign_key: 'active_id'
  has_many :requests_received, class_name: 'Friendship', foreign_key: 'passive_id'
  has_many :passive_friends, through: :requests_sent, source: :passive
  has_many :active_friends, through: :requests_received, source: :active

  def self.search(name)
    all = User.all
    all.select { |user| user.name.include?(name) }
  end

end
