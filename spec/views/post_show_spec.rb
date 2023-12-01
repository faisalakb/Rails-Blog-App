require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  before do
    @user = User.create(name: 'Yusaf')
    @post = Post.create(author: @user, title: 'Hello7', text: 'This is my seventh post')
    @comment1 = Comment.create(post: @post, text: 'sample comment', user: @user)

    visit user_post_path(@user, @post)
  end

  scenario 'I can see the post\'s title' do
    expect(page).to have_content('This is my seventh post')
  end

  scenario 'I can see who wrote the post' do
    expect(page).to have_content('Yusaf')
  end

  scenario 'I can see how many comments it has' do
    expect(page).to have_content('Comments: 1, Likes: 0')
  end

  scenario 'I can see how many likes it has' do
    expect(page).to have_content('Comments: 1, Likes: 0')
  end

  scenario 'I can see the post body' do
    expect(page).to have_content('This is my seventh post')
  end

  scenario 'I can see the username of each commentor' do
    expect(page).to have_content('Yusaf:')
  end

  scenario 'I can see the comment each commentor left' do
    expect(page).to have_content('sample comment')
  end
end
