require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new }
  
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
