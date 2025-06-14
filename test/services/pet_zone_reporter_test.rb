require "test_helper"

class PetZoneReporterTest < ActiveSupport::TestCase
  def setup
    @dog1 = Pet.create!(pet_type: "dog", tracker_type: "small", owner_id: 1, in_zone: false)
    @dog2 = Pet.create!(pet_type: "dog", tracker_type: "small", owner_id: 2, in_zone: false)
    @dog3 = Pet.create!(pet_type: "dog", tracker_type: "medium", owner_id: 3, in_zone: false)
    @cat1 = Pet.create!(pet_type: "cat", tracker_type: "big", owner_id: 4, in_zone: false)
  end

  test "returns correct nested report structure" do
    result = PetZoneReporter.call

    expected = {
      "dog" => {
        "small" => 2,
        "medium" => 1
      },
      "cat" => {
        "big" => 1
      }
    }

    assert_equal expected, result
  end
end
