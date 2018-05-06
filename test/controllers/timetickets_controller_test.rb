require 'test_helper'

class TimeticketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timeticket = timetickets(:one)
  end

  test "should get index" do
    get timetickets_url
    assert_response :success
  end

  test "should get new" do
    get new_timeticket_url
    assert_response :success
  end

  test "should create timeticket" do
    assert_difference('Timeticket.count') do
      post timetickets_url, params: { timeticket: { banana_id: @timeticket.banana_id, time: @timeticket.time } }
    end

    assert_redirected_to timeticket_url(Timeticket.last)
  end

  test "should show timeticket" do
    get timeticket_url(@timeticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_timeticket_url(@timeticket)
    assert_response :success
  end

  test "should update timeticket" do
    patch timeticket_url(@timeticket), params: { timeticket: { banana_id: @timeticket.banana_id, time: @timeticket.time } }
    assert_redirected_to timeticket_url(@timeticket)
  end

  test "should destroy timeticket" do
    assert_difference('Timeticket.count', -1) do
      delete timeticket_url(@timeticket)
    end

    assert_redirected_to timetickets_url
  end
end
