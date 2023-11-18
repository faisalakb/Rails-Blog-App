# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:posts).with_foreign_key(:author_id).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }

  describe '#recent_posts' do
    let(:user) { create(:user) }

    it 'returns the most recent posts for the user' do
      recent_posts = create_list(:post, 5, author: user)
      expect(user.recent_posts).to eq(recent_posts.reverse)
    end

    it 'returns the specified number of recent posts' do
      create_list(:post, 10, author: user)
      expect(user.recent_posts(3).count).to eq(3)
    end
  end
end

