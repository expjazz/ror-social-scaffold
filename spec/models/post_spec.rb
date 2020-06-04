require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:post) }

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content) }
  end

  describe 'associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should belong_to(:user) }
  end
end
