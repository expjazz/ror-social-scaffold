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

  def friends(bool)
    f1 = active_friends
    active = []
    passive = []
    f1.each do |f|
      friendship = Friendship.find_by(active_id: f.id, passive_id: self.id, status: bool)
      active << friendship.active if friendship
    end
    f2 = passive_friends
    f2.each do |f|
      friendship = Friendship.find_by(passive_id: f.id, active_id: self.id, status: bool)
      passive << friendship.passive if friendship
    end
    if active && passive
      active + passive
    elsif active
      active
    elsif
      passive
    else
      []
    end
  end
end
