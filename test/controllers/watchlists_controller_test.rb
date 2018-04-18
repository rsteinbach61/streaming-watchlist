require 'test_helper'

class WatchlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get watchlists_new_url
    assert_response :success
  end

  test "should get edit" do
    get watchlists_edit_url
    assert_response :success
  end

  test "should get show" do
    get watchlists_show_url
    assert_response :success
  end

end
