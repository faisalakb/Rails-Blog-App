# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.allow_nil }
  end

  describe 'methods' do
    describe '#recent_posts' do
      it 'returns the 3 most recent posts' do
        user = User.create(name: 'John Doe')
        post1 = Post.create(title: 'Post 1', author: user, created_at: 5.days.ago)
        post2 = Post.create(title: 'Post 2', author: user, created_at: 3.days.ago)
        post3 = Post.create(title: 'Post 3', author: user, created_at: 1.day.ago)
        Post.create(title: 'Post 4', author: user, created_at: 7.days.ago)

        recent_posts = user.recent_posts

        expect(recent_posts).to eq([post3, post2, post1])
      end

      it 'returns the specified number of most recent posts' do
        user = User.create(name: 'Jane Doe')
        Post.create(title: 'Post 1', author: user, created_at: 5.days.ago)
        post2 = Post.create(title: 'Post 2', author: user, created_at: 3.days.ago)
        post3 = Post.create(title: 'Post 3', author: user, created_at: 1.day.ago)
        Post.create(title: 'Post 4', author: user, created_at: 7.days.ago)

        recent_posts = user.recent_posts(2)

        expect(recent_posts).to eq([post3, post2])
      end
    end
  end
end
