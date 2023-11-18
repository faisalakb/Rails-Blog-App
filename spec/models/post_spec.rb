require 'rails_helper'

RSpec.describe Post, type: :model do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  
    describe '#update_post_counter' do
      it 'updates the posts counter for the author' do
        user = create(:user)
        post = create(:post, author: user)
        post.update_post_counter
        user.reload
        expect(user.posts_counter).to eq(1)
      end
    end
  
    describe '#recent_comments' do
      let(:post) { create(:post) }
  
      it 'returns the most recent comments for the post' do
        recent_comments = create_list(:comment, 5, post: post)
        expect(post.recent_comments).to eq(recent_comments.reverse)
      end
  
      it 'returns the specified number of recent comments' do
        create_list(:comment, 10, post: post)
        expect(post.recent_comments(3).count).to eq(3)
      end
    end
  end
  