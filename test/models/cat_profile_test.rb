require "test_helper"

class CatProfileTest < ActiveSupport::TestCase
  test "valid lost_tracker values" do
    cat_profile = cat_profiles(:one)
    assert cat_profile.valid?

    cat_profile.lost_tracker = false
    assert cat_profile.valid?
  end

  test "invalid lost_tracker values" do
    cat_profile = cat_profiles(:one)

    cat_profile.lost_tracker = nil
    assert_not cat_profile.valid?
    assert_includes cat_profile.errors[:lost_tracker], "is not included in the list"
  end
end
