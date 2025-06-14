require "test_helper"

class Api::V1::PetsControllerTest < ActionDispatch::IntegrationTest
  test "creates a valid dog pet" do
    pet_params = {
      pet: {
        pet_type: "dog",
        tracker_type: "medium",
        owner_id: 1,
        in_zone: true
      }
    }

    post api_v1_pets_path, params: pet_params, as: :json
    assert_response :created

    json = JSON.parse(response.body)
    assert_equal "dog", json["pet_type"]
    assert_equal "medium", json["tracker_type"]
  end

  test "creates a valid cat pet with cat_profile" do
    pet_params = {
      pet: {
        pet_type: "cat",
        tracker_type: "small",
        owner_id: 2,
        in_zone: false,
        cat_profile_attributes: {
          lost_tracker: false
        }
      }
    }

    post api_v1_pets_path, params: pet_params, as: :json
    assert_response :created

    json = JSON.parse(response.body)
    assert_equal "cat", json["pet_type"]
    assert_equal false, json["cat_profile"]["lost_tracker"]
  end

  test "fails to create invalid pet" do
    pet_params = { pet: { pet_type: "cat", tracker_type: "medium", owner_id: 3, in_zone: true } }
    # medium tracker not valid for cats

    post api_v1_pets_path, params: pet_params, as: :json
    assert_response :unprocessable_entity

    json = JSON.parse(response.body)
    assert_includes json["errors"].join, "Tracker type is invalid for pet type cat"
  end
end
