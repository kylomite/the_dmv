require 'spec_helper'
require './lib/facility'
require './lib/registrant'

RSpec.configure do |config|
  config.formatter = :documentation
  end

RSpec.describe Facility do
  before(:each) do

    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
  
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
  
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
      expect(@facility.registered_vehicles).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end
  describe'#register_vehicle' do
    before(:each) do
      @facility.add_service('Vehicle Registration')
    end

    it 'will be unavailable at facilities that do not offer the service' do
      facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
      facility_2.register_vehicle(@cruz)

      expect(facility_2.registered_vehicles).to be_empty
    end

    it 'will use all helper methods to fulfill processed' do
      expect{@facility.add_to_registered_vehicle(@cruz)}.to change{@facility.registered_vehicles}.to([@cruz])
      expect{@facility.update_vehicle_registration(@cruz)}.to change{@cruz.registration_date}.to(Date.today)
      expect{@facility.plate_service(@cruz)}.to change{@cruz.plate_type}.to(:regular)
      expect{@facility.plate_service(@bolt)}.to change{@bolt.plate_type}.to(:ev)
      expect{@facility.plate_service(@camaro)}.to change{@camaro.plate_type}.to(:antique)
      expect{@facility.plate_service(@cruz)}.to change{@facility.collected_fees}.to(425)
      expect{@facility.plate_service(@bolt)}.to change{@facility.collected_fees}.to(625)
      expect{@facility.plate_service(@camaro)}.to change{@facility.collected_fees}.to(650)
    end
  end
  
  describe '#add_to_registered_vehicle' do
    before(:each) do
      @facility.add_service('Vehicle Registration')
    end

    it 'will add specified vehicle to @register_vehicles array' do 
      expect(@facility.registered_vehicles).not_to include @cruz

      expect{@facility.add_to_registered_vehicle(@cruz)}.to change{@facility.registered_vehicles}.to([@cruz])
    end
  end

  describe '#update_vehicle_registration' do
    before(:each) do
      @facility.add_service('Vehicle Registration')
    end
    
    it 'will assign current date as vehicles registration date' do
      expect(@cruz.registration_date).to eq nil

      expect{@facility.update_vehicle_registration(@cruz)}.to change{@cruz.registration_date}.to(Date.today)
    end
  end

  describe '#plate_service' do
    before(:each) do
      @facility.add_service('Vehicle Registration')
    end
    
    it 'will assign a plate type based on regular/EV/antique status ' do
      expect{@facility.plate_service(@cruz)}.to change{@cruz.plate_type}.to(:regular)
      expect{@facility.plate_service(@bolt)}.to change{@bolt.plate_type}.to(:ev)
      expect{@facility.plate_service(@camaro)}.to change{@camaro.plate_type}.to(:antique)
    end
  
    it 'will collect $100 when registering a regular vehicle' do
      expect{@facility.plate_service(@cruz)}.to change{@facility.collected_fees}.to(100)
    end

    it 'will collect $200 when registering an EV' do
      expect{@facility.plate_service(@bolt)}.to change{@facility.collected_fees}.to(200)
    end
    
    it 'will collect $25 when registering an antique vehicle' do
      expect{@facility.plate_service(@camaro)}.to change{@facility.collected_fees}.to(25)
    end

    it 'can keep running total of collected fees' do
      expect{@facility.plate_service(@cruz)}.to change{@facility.collected_fees}.to(100)
      expect{@facility.plate_service(@bolt)}.to change{@facility.collected_fees}.to(300)
      expect{@facility.plate_service(@camaro)}.to change{@facility.collected_fees}.to(325)
    end
  end


  describe'#administer_written_test' do
    before(:each) do
      @facility.add_service('Written Test')
      @registrant = Registrant.new('Bruce', 18, true )
      @registrant_2 = Registrant.new('Penny', 15 )
    end

    it 'will be unavailable at facilities that do not offer the service' do
      facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})

      expect{facility_2.administer_written_test(@registrant)}.not_to change{@registrant.license_data}
    end
    
    it 'will be unavailable to registrants who have not earned a permit' do
      expect{@facility.administer_written_test(@registrant_2)}.not_to change{@registrant_2.license_data}
    end

    it 'will update registrants license_data attribute to include a passed written test' do
      expect{@facility.administer_written_test(@registrant)}.to change{@registrant.license_data}.from({:written=>false, :license=>false, :renewed=>false}).to({:written=>true, :license=>false, :renewed=>false})
    end
  end

  describe'#administer_road_test' do
    before(:each) do
      @facility.add_service('Road Test')
      @registrant = Registrant.new('Bruce', 18, true )
      @registrant_2 = Registrant.new('Penny', 15, true )
      @registrant_3 = Registrant.new('Katakuri', 15 )
    end
    
    it 'will be unavailable at facilities that do not offer the service' do
      facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})

      expect{facility_2.administer_road_test(@registrant)}.not_to change{@registrant.license_data}
    end

    it 'will be unavailable to registrants who have not earned a permit' do
      expect{@facility.administer_road_test(@registrant_3)}.not_to change{@registrant_3.license_data}
    end
    
    it 'will be unavailable to registrants who have not passed written test' do
      expect{@facility.administer_road_test(@registrant_2)}.not_to change{@registrant_2.license_data}
    end

    it 'will update registrants license_data attribute to include a passed road test' do
      @facility.add_service('Written Test')
      @facility.administer_written_test(@registrant)

      expect{@facility.administer_road_test(@registrant)}.to change{@registrant.license_data}.from({:written=>true, :license=>false, :renewed=>false}).to({:written=>true, :license=>true, :renewed=>false})
    end
  end

  describe'#renew_drivers_license' do
    before(:each) do
      @facility.add_service('Written Test')
      @facility.add_service('Road Test')
      @facility.add_service('Renew License')
      @registrant = Registrant.new('Bruce', 18, true )
      @registrant_2 = Registrant.new('Penny', 15, true )
      @registrant_3 = Registrant.new('Katakuri', 15, true)
      @registrant_4 = Registrant.new('Ozai', 47 )
    end
  
    it 'will be unavailable at facilities that do not offer the service' do
      facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
      expect{facility_2.renew_drivers_license(@registrant)}.not_to change{@registrant.license_data}
      
    end

    it 'will be unavailable to registrants who have not earned a permit' do
      expect{@facility.renew_drivers_license(@registrant_4)}.not_to change{@registrant_4.license_data}
    end
    
    it 'will be unavailable to registrants who have not passed written test' do
      expect{@facility.renew_drivers_license(@registrant_3)}.not_to change{@registrant_3.license_data}
    end
    
    it 'will be unavailable to registrants who have not passed road test' do
      @facility.administer_written_test(@registrant_2)

      expect{@facility.renew_drivers_license(@registrant_2)}.not_to change{@registrant_2.license_data}
    end

    it 'will update registrants license_data attribute to include a renewed license' do
      @facility.administer_written_test(@registrant)
      @facility.administer_road_test(@registrant)

      expect{@facility.renew_drivers_license(@registrant)}.to change{@registrant.license_data}.from({:written=>true, :license=>true, :renewed=>false}).to({:written=>true, :license=>true, :renewed=>true})
    end
  end
end
