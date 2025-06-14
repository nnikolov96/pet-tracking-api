class CatProfile < ApplicationRecord
  belongs_to :pet
  validates :lost_tracker, inclusion: { in: [ true, false ] }
end
