require './lib/vehicle.rb'

class Facility
  attr_reader :name, 
              :address,
              :phone,
              :services,
              :registered_vehicles,
              :collected_fees

  def initialize(fac_info)
    @name = fac_info[:name]
    @address = fac_info[:address]
    @phone = fac_info[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if @services.include?('Vehicle Registration')
      @registered_vehicles << vehicle
      vehicle.registration_date = Date.today
      if vehicle.antique? == true
        vehicle.plate_type = :antique
      elsif vehicle.electric_vehicle? == true
        vehicle.plate_type = :ev
      else 
        vehicle.plate_type = :regular
      end
    end
  end

  def collect_fees

  end
end
