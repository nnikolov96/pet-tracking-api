class Pet < ApplicationRecord
  has_one :cat_profile, dependent: :destroy
  enum :pet_type, { dog: "dog", cat: "cat" }
  enum :tracker_type, { small: "small", medium: "medium", big: "big" }

  accepts_nested_attributes_for :cat_profile, allow_destroy: true

  validates :pet_type, :tracker_type, :owner_id, presence: true
  validate :cat_profile_only_for_cats
  validate :validate_tracker_type_for_pet_type

  private

  def cat_profile_only_for_cats
    if dog? && cat_profile.present?
      errors.add(:cat_profile, "only applies to cats")
    end
  end

  def validate_tracker_type_for_pet_type
    return if pet_type.blank? || tracker_type.blank?

    allowed =
    case pet_type
    when "cat"
      %w[small big]
    when "dog"
      %w[small medium big]
    else
      []
    end

    unless allowed.include?(tracker_type)
      errors.add(:tracker_type, "is invalid for pet type #{pet_type}")
    end
  end
end
