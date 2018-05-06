require 'test_helper'

class TimeticketControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get timeticket_index_url
    assert_response :success
  end

end
