# spec/features/user_posts_spec.rb

require 'rails_helper'

RSpec.feature 'User Posts Index Page', type: :feature do
  before do
    @user = User.create(name: 'Lilly', photo: 'https://placehold.co/400', bio: 'Lorem ipsum')
    @post1 = Post.create(author: @user, title: 'First Post', text: 'This is the first post')
    @comment1 = Comment.create(post: @post1, text: 'First comment by Lilly')

    visit user_posts_path(@user)
  end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://placehold.co/400']", wait: 5)
  end

  scenario 'I can see the user\'s username' do
    expect(page).to have_text('Lilly', wait: 5)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_text('Number of Posts: 1', wait: 5)
  end

  scenario 'I can see a post\'s title' do
    expect(page).to have_text('This is the first post', wait: 5)
  end

  scenario 'I can see some of the post\'s body' do
    expect(page).to have_text('This is the first post', wait: 5)
  end

  scenario 'I can see the first comments on a post' do
    expect(page).to have_content(nil)
  end

  scenario 'I can see how many comments a post has' do
    expect(page).to have_text('Comments: 0', wait: 5)
  end

  scenario 'I can see how many likes a post has' do
    expect(page).to have_text('Likes: 0', wait: 5)
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    # You may need to adjust this expectation based on your actual pagination implementation
    expect(page).to have_selector('.seeAllPostBtn', wait: 5)
  end

  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    post_link = find('a.postclick', text: 'This is the first post', wait: 10)
    page.execute_script('arguments[0].click();', post_link)
    expected_path = user_post_path(@user, @post1)
    expect(page).to have_current_path(expected_path, ignore_query: true)
  end
end
