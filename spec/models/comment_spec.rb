require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:post).class_name('Post').with_foreign_key(:post_id) }
  it { should belong_to(:user).class_name('User').with_foreign_key(:user_id) }

  describe '#update_comments_counter' do
    it 'updates the comments counter for the post' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'Test Post', author: user)
      comment = Comment.create(post: post, user: user)

      comment.update_comments_counter
      post.reload

      expect(post.comments_counter).to eq(1)
    end
  end
end
