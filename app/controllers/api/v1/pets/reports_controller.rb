module Api
  module V1
    module Pets
      class ReportsController < ApplicationController
        def show
          render json: PetZoneReporter.call
        end
      end
    end
  end
end
