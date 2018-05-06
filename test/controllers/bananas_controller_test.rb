require 'test_helper'

class BananasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @banana = bananas(:one)
  end

  test "should get index" do
    get bananas_url
    assert_response :success
  end

  test "should get new" do
    get new_banana_url
    assert_response :success
  end

  test "should create banana" do
    assert_difference('Banana.count') do
      post bananas_url, params: { banana: { color: @banana.color, garden_id: @banana.garden_id, ismaxripe: @banana.ismaxripe, nexttime: @banana.nexttime, numid: @banana.numid, posx: @banana.posx, posy: @banana.posy, ripeState: @banana.ripeState, ripeness: @banana.ripeness, slottime: @banana.slottime, specialtype: @banana.specialtype } }
    end

    assert_redirected_to banana_url(Banana.last)
  end

  test "should show banana" do
    get banana_url(@banana)
    assert_response :success
  end

  test "should get edit" do
    get edit_banana_url(@banana)
    assert_response :success
  end

  test "should update banana" do
    patch banana_url(@banana), params: { banana: { color: @banana.color, garden_id: @banana.garden_id, ismaxripe: @banana.ismaxripe, nexttime: @banana.nexttime, numid: @banana.numid, posx: @banana.posx, posy: @banana.posy, ripeState: @banana.ripeState, ripeness: @banana.ripeness, slottime: @banana.slottime, specialtype: @banana.specialtype } }
    assert_redirected_to banana_url(@banana)
  end

  test "should destroy banana" do
    assert_difference('Banana.count', -1) do
      delete banana_url(@banana)
    end

    assert_redirected_to bananas_url
  end
end
