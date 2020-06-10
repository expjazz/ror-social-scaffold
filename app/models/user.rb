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
    active = friend_active(bool)
    passive = friend_passive(bool)
    if active && passive
      active + passive
    elsif active
      active
    elsif passive
      passive
    else
      []
    end
  end

  def friend_active(bool)
    active = []
    f1 = active_friends
    f1.each do |f|
      friendship = Friendship.find_by(active_id: f.id, passive_id: id, status: bool)
      active << friendship.active if friendship
    end
    active
  end

  def friend_passive(bool)
    passive = []
    f2 = passive_friends
    f2.each do |f|
      friendship = Friendship.find_by(passive_id: f.id, active_id: id, status: bool)
      passive << friendship.passive if friendship
    end
    passive
  end

  def check_friends_of_not_friends(not_friend)
    if !friends(true).include?(not_friend)
      not_friend.friends(true).select do |x|
        friends(true).include?(x) && !friends(false).include?(x)
      end
    else
      []
    end
  end

  def check_mutual_friends(friend)
    friend.friends(true). select { |x| friends(true).include?(x) }
  end
end
