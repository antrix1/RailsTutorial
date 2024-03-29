require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    log_in_as(@user)
    get user_path @user
    assert_template 'users/show'
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_select 'div.pagination'
  end
end
