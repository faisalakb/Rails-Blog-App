require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_like_counter' do
    it 'updates the likes_counter of the associated post after save' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'Test Post', author: user, likes_counter: 0)

      expect(post.likes_counter).to eq(0)

      Like.create(user: user, post: post)

      expect(post.likes_counter).to eq(1)

      Like.create(user: user, post: post)

      expect(post.likes_counter).to eq(2)
    end
  end
end
