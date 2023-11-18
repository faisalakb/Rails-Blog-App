# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.allow_nil }
    it { should validate_numericality_of(:likes_counter).only_integer.allow_nil }
  end

  describe 'methods' do
    describe '#update_post_counter' do
      it 'updates the user posts_counter attribute' do
        user = User.create(name: 'Sintheys')
        post = Post.create(title: 'Good morning', author: user)

        post.update_post_counter

        expect(user.reload.posts_counter).to eq(1)
      end
    end

    describe '#recent_comments' do
      it 'returns the 5 most recent comments' do
        user = User.create(name: 'Raihan')
        post = Post.create(title: 'Sample Post', author: user)
        comment1 = Comment.create(user: user, post: post, text: 'comment 1', created_at: 5.days.ago)
        comment2 = Comment.create(user: user, post: post, text: 'comment 2', created_at: 4.days.ago)
        comment3 = Comment.create(user: user, post: post, text: 'comment 3', created_at: 3.days.ago)
        comment4 = Comment.create(user: user, post: post, text: 'comment 4', created_at: 2.days.ago)
        comment5 = Comment.create(user: user, post: post, text: 'comment 5', created_at: 1.day.ago)

        recent_comments = post.recent_comments

        expect(recent_comments).to eq([comment5, comment4, comment3, comment2, comment1])
      end
    end
  end
end
