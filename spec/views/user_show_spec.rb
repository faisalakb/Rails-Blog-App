require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  before do
    @user = User.create(name: 'Lilly', photo: 'https://placehold.co/400', bio: 'Teacher from Poland')
    @post1 = Post.create(author: @user, title: 'Post: Hello3', text: 'This is my third post')
    visit user_path(@user)
  end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://placehold.co/400']")
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
    expect(page).to have_content('Post: Hello3')
    expect(page).to have_content('This is my third post')
  end

  scenario 'I can see a button to view all of a user\'s posts' do
    expect(page).to have_link('See all posts', href: user_posts_path(@user))
  end

  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    click_link('See all posts')
    expect(current_path).to eq(user_posts_path(@user))
  end
end
