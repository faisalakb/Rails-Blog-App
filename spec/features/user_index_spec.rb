# spec/features/user_index_spec.rb

require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    # Create users directly (replace this with your actual user creation logic)
    @user1 = User.create(name: 'Lilly', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
    @user2 = User.create(name: 'Yusaf', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')

    # Create posts associated with the users
    @post1 = Post.create(author: @user1, title: 'Post by Lilly')
    @post2 = Post.create(author: @user2, title: 'Post by Yusaf')
  end

  scenario 'I can see the username of all other users' do
    visit users_path

    expect(page).to have_content('Lilly')
    expect(page).to have_content('Yusaf')
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D']")
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D']")
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Number of posts: 1', count: 2)
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path

    click_link 'Lilly' # Assuming the user's name is a link to their show page

    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content('Lilly')
    expect(page).to have_content('Number of Posts: 1') 
  end
end
