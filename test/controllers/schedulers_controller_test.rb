require 'test_helper'

class SchedulersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scheduler = schedulers(:one)
  end

  test "should get index" do
    get schedulers_url
    assert_response :success
  end

  test "should get new" do
    get new_scheduler_url
    assert_response :success
  end

  test "should create scheduler" do
    assert_difference('Scheduler.count') do
      post schedulers_url, params: { scheduler: {  } }
    end

    assert_redirected_to scheduler_url(Scheduler.last)
  end

  test "should show scheduler" do
    get scheduler_url(@scheduler)
    assert_response :success
  end

  test "should get edit" do
    get edit_scheduler_url(@scheduler)
    assert_response :success
  end

  test "should update scheduler" do
    patch scheduler_url(@scheduler), params: { scheduler: {  } }
    assert_redirected_to scheduler_url(@scheduler)
  end

  test "should destroy scheduler" do
    assert_difference('Scheduler.count', -1) do
      delete scheduler_url(@scheduler)
    end

    assert_redirected_to schedulers_url
  end
end
