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
      add_to_registered_vehicle(vehicle) 
      update_vehicle_registration(vehicle)
      plate_service(vehicle)
    end
  end

  def add_to_registered_vehicle(vehicle)
    @registered_vehicles << vehicle
  end

  def update_vehicle_registration(vehicle)
    vehicle.registration_date = Date.today
  end

  def plate_service(vehicle)
    if vehicle.antique? == true
      @collected_fees += 25
      vehicle.plate_type = :antique
    elsif vehicle.electric_vehicle? == true
      @collected_fees += 200
      vehicle.plate_type = :ev
    else 
      @collected_fees += 100
      vehicle.plate_type = :regular
    end
  end

  def administer_written_test(registrant)

    if @services.include?("Written Test") && registrant.permit == true
      registrant.license_data[:written] = true
    else
      false
    end
  end
  
  def administer_road_test(registrant)
    if @services.include?("Road Test") && registrant.license_data[:written] == true
      registrant.license_data[:license] = true
    else
      false
    end
  end

  def renew_drivers_license(registrant)
    if @services.include?("Renew License") && registrant.license_data[:license] == true
      registrant.license_data[:renewed] = true
    else
      false
    end
  end
end
