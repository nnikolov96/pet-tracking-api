module Api
  module V1
    class PetsController < ApplicationController
      def create
        pet = Pet.new(pet_params)
        if pet.save
          render json: pet.as_json(include: :cat_profile), status: :created
        else
          render json: { errors: pet.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def pet_params
        params.require(:pet).permit(
          :pet_type,
          :tracker_type,
          :owner_id,
          :in_zone,
          cat_profile_attributes: [ :lost_tracker ]
        )
      end
    end
  end
end
