class Friendship < ApplicationRecord
  belongs_to :active, class_name: 'User'
  belongs_to :passive, class_name: 'User'
end
