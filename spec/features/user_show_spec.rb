require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  before do
    # Create a user and associated posts directly (replace this with your actual creation logic)
    @user = User.create(name: 'Lilly', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', bio: 'Teacher from Poland')
    @post1 = Post.create(author: @user, title: 'Hello3', text: 'This is my third post')
    visit user_path(@user)
  end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D']")
  end

  scenario 'I can see the user\'s username' do
    expect(page).to have_content('Lilly')
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content('Number of Posts: 1')
  end

  scenario 'I can see the user\'s bio' do
    expect(page).to have_content('Teacher from Poland')
  end

  scenario 'I can see the user\'s first 3 posts' do
    expect(page).to have_content('Post 1')
    expect(page).to have_content('This is my third post')

  end

  scenario 'I can see a button to view all of a user\'s posts' do
    expect(page).to have_link('See all posts', href: user_posts_path(@user))
  end

  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    click_link 'Post 1'
    expect(current_path).to eq(post_path(@post1))
  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(@user))
  end
end
