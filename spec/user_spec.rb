# test/models/user_test.rb

require 'rails_helper'

class UserTest < ActiveSupport::TestCase
  test 'should have many comments' do
    assert_respond_to users(:one), :comments
  end

  test 'should have many likes' do
    assert_respond_to users(:one), :likes
  end

  test 'should have many posts' do
    assert_respond_to users(:one), :posts
  end

  test 'should destroy associated comments when user is destroyed' do
    user = users(:one)
    assert_difference('Comment.count', -1) do
      user.destroy
    end
  end

  test 'should destroy associated likes when user is destroyed' do
    user = users(:one)
    assert_difference('Like.count', -1) do
      user.destroy
    end
  end

  test 'should destroy associated posts when user is destroyed' do
    user = users(:one)
    assert_difference('Post.count', -1) do
      user.destroy
    end
  end

  test 'should return recent posts' do
    user = users(:one)
    recent_posts = user.recent_posts(3)

    assert_equal 3, recent_posts.length
    assert_equal posts(:post3), recent_posts.first
    assert_equal posts(:post2), recent_posts.second
    assert_equal posts(:post1), recent_posts.third
  end
end
