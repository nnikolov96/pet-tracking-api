require "test_helper"

class PetTest < ActiveSupport::TestCase
  test "valid dog without cat profile" do
    pet = pets(:two)
    assert pet.valid?
  end

  test "invalid dog with cat profile" do
    pet = pets(:two)
    pet.build_cat_profile(lost_tracker: true)
    assert_not pet.valid?
    assert_includes pet.errors[:cat_profile], "only applies to cats"
  end

  test "valid cat with cat profile" do
    pet = pets(:one)
    pet.build_cat_profile(lost_tracker: false)
    assert pet.valid?
  end

  test "invalid pet missing required fields" do
    pet = Pet.new
    assert_not pet.valid?
    assert_includes pet.errors[:pet_type], "can't be blank"
    assert_includes pet.errors[:tracker_type], "can't be blank"
    assert_includes pet.errors[:owner_id], "can't be blank"
  end

  test "invalid tracker_type for cat" do
    pet = pets(:one)
    pet.tracker_type = "medium"
    assert_not pet.valid?
    assert_includes pet.errors[:tracker_type], "is invalid for pet type cat"
  end

  test "valid tracker_type for dog" do
    pet = Pet.new(pet_type: "dog", tracker_type: "medium", owner_id: 1, in_zone: true)
    assert pet.valid?
  end
end
