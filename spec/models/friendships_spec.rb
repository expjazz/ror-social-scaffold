require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject { Friendship.new }

  describe 'associations' do
    it { should belong_to(:active) }
    it { should belong_to(:passive) }
  end
end
