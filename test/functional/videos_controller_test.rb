require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  test "should get movies" do
    get :movies
    assert_response :success
  end

  test "should get tvshows" do
    get :tvshows
    assert_response :success
  end

end
