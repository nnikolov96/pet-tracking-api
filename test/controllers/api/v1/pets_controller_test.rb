require "test_helper"

class Api::V1::PetsControllerTest < ActionDispatch::IntegrationTest
  test "successfully creates a valid dog pet" do
    assert_difference("Pet.count", 1) do
      post api_v1_pets_path, params: {
        pet: {
          pet_type: "dog",
          tracker_type: "medium",
          owner_id: 1,
          in_zone: true
        }
      }, as: :json
    end

    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "dog", json["pet_type"]
    assert_equal "medium", json["tracker_type"]
    assert_nil json["cat_profile"]
  end

  test "successfully creates a valid cat pet with cat_profile" do
    assert_difference([ "Pet.count", "CatProfile.count" ], 1) do
      post api_v1_pets_path, params: {
        pet: {
          pet_type: "cat",
          tracker_type: "small",
          owner_id: 2,
          in_zone: false,
          cat_profile_attributes: {
            lost_tracker: false
          }
        }
      }, as: :json
    end

    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "cat", json["pet_type"]
    assert_equal "small", json["tracker_type"]
    assert json["cat_profile"]
    assert_equal false, json["cat_profile"]["lost_tracker"]
  end

  test "fails to create cat with invalid tracker_type" do
    assert_no_difference("Pet.count") do
      post api_v1_pets_path, params: {
        pet: {
          pet_type: "cat",
          tracker_type: "medium",
          owner_id: 3,
          in_zone: true
        }
      }, as: :json
    end

    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert_includes json["errors"], "Tracker type is invalid for pet type cat"
  end

  test "fails to create pet when required fields are missing" do
    assert_no_difference("Pet.count") do
      post api_v1_pets_path, params: { pet: { owner_id: 1 } }, as: :json
    end

    assert_response :unprocessable_entity
    json = JSON.parse(response.body)

    assert_includes json["errors"], "Pet type can't be blank"
    assert_includes json["errors"], "Tracker type can't be blank"
  end
end
