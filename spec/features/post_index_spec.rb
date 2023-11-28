require 'rails_helper'

RSpec.feature 'User Posts Index Page', type: :feature do
  before do
    @user = User.create(name: 'Lilly', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', bio: 'Teacher from Poland')
    @post1 = Post.create(author: @user, title: 'Hello3', text: 'This is my third post')
    @comment1 = Comment.create(post: @post1, text: 'comments by li')

    visit user_posts_path(@user)
  end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D']", wait: 5)
  end

  scenario 'I can see the user\'s username' do
    expect(page).to have_text('Lilly', wait: 5)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_text('Number of Posts: 1', wait: 5)
  end

  scenario 'I can see a post\'s title' do
    expect(page).to have_text('This is my third post', wait: 5)
  end

  scenario 'I can see some of the post\'s body' do
    expect(page).to have_text('This is my third post', wait: 5)
  end

  scenario 'I can see the first comments on a post' do
    expect(page).to have_text('comments by li', wait: 5)
  end

  scenario 'I can see how many comments a post has' do
    expect(page).to have_text('Comments: 1', wait: 5)
  end

  scenario 'I can see how many likes a post has' do
    expect(page).to have_text('Likes: 0', wait: 5)
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    # You may need to adjust this expectation based on your actual pagination implementation
    expect(page).to have_selector('.seeAllPostBtn', wait: 5)
  end

  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    find('a.postclick', text: 'Post #1', visible: :all, wait: 5).click
    expect(current_path).to eq(user_post_path(@user, @post1))
  end
end
