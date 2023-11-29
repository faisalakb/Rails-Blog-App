# spec/features/user_index_spec.rb

require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'Lilly', photo: 'https://placehold.co/400')
    @user2 = User.create(name: 'Yusaf', photo: 'https://placehold.co/400')

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

    expect(page).to have_css("img[src*='https://placehold.co/400']", count: 2)
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Number of posts: 1', count: 18)
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path

    click_link 'Yusaf'

    expect(page).to have_current_path(user_path(@user2))
  end
end
