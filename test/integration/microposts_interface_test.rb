require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "micrpost interface" do
    log_in_as @user
    get root_url
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, micropost: {content: ""}
    end
    #Valid submission
    content = "This micropost really ties the room together"
    assert_difference "Micropost.count", 1 do
      post microposts_path, micropost: {content: content}
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post
    assert_select 'a', text: "delete"
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference "Micropost.count", -1 do |variable|
      delete micropost_path(first_micropost)
    end
    # Visit a different user
    get user_path(uses(:archer))
    assert_select 'a', text: delete, count: 0
  end

end
