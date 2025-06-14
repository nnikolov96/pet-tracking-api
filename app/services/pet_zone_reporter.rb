class PetZoneReporter
  def self.call
    new.call
  end

  def call
    grouped = Pet.where(in_zone: false).group(:pet_type, :tracker_type).count

    grouped.each_with_object({}) do |((pet_type, tracker_type), count), hash|
      hash[pet_type] ||= {}
      hash[pet_type][tracker_type] = count
    end
  end
end
