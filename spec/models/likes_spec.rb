require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new }
  describe 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id).case_insensitive }
  end
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
