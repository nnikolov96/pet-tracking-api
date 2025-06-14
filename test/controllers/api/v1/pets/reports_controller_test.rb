require "test_helper"

class Api::V1::Pets::ReportsControllerTest < ActionDispatch::IntegrationTest
  def setup
    Pet.create!(pet_type: "dog", tracker_type: "small", owner_id: 1, in_zone: false)
    Pet.create!(pet_type: "dog", tracker_type: "small", owner_id: 2, in_zone: false)
    Pet.create!(pet_type: "dog", tracker_type: "medium", owner_id: 3, in_zone: false)
    Pet.create!(pet_type: "cat", tracker_type: "big", owner_id: 4, in_zone: false)
  end

  test "returns correct nested report structure" do
    get api_v1_pets_report_path, as: :json
    assert_response :success

    expected = {
      "dog" => {
        "small" => 2,
        "medium" => 1
      },
      "cat" => {
        "big" => 1
      }
    }

    json = JSON.parse(response.body)

    assert_equal expected, json
  end
end
