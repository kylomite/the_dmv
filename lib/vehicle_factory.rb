require './lib/dmv_data_service'
require './lib/vehicle'

class VehicleFactory

    attr_accessor :vehicle_details,
                  :vehicles

    def initialize
        @vehicle_details = {vin: nil, year: nil, make: nil, model: nil, engine: :ev, plate_type: nil, registration_date: nil}
        @vehicles = []
    end

    def transform_vehicle_data(vehicle) 
        @vehicle_details [:vin] = vehicle[:vin_1_10]
        @vehicle_details [:year] = vehicle[:model_year]
        @vehicle_details [:make] = vehicle[:make]
        @vehicle_details [:model] = vehicle[:model]
        @vehicles.push(Vehicle.new(@vehicle_details))
    end

    def create_vehicles(vehicle_list)
        vehicle_list.each {|vehicle|
            transform_vehicle_data(vehicle)
        }
        @vehicles
    end

end

