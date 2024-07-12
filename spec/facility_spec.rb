require 'spec_helper'
require './lib/facility'

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
    it 'will add specified vehicle to @register_vehicles array' do 
      
      @facility.add_service('Vehicle Registration')
      
      expect(@facility.registered_vehicles).not_to include @cruz

      @facility.register_vehicle(@cruz)

      expect(@facility.registered_vehicles).to include @cruz
    end

    it 'will assign current date as vehicles registration date' do

    end

    it 'will assign a plate type based on regular/EV/antique status ' do 
      
      @facility.add_service('Vehicle Registration')
      #require'pry';binding.pry
      @facility.register_vehicle(@cruz)
      @facility.register_vehicle(@bolt)
      @facility.register_vehicle(@camaro)
      
      expect(@cruz.plate_type).to eq :regular
      expect(@bolt.plate_type).to eq :ev
      expect(@camaro.plate_type).to eq :antique
    end
  end
  
  
  describe'#collect_fees' do
    
    it 'will cost $100 to register a regular vehicle' do

    end
    
    it 'will cost $25 to register an antique vehicle' do

    end

    it 'will cost $200 to register any EV' do

    end

  end

  describe'#new_drivers_license' do
    it 'will administer written and road tests' do

    end

    describe'#administer_written_test' do
      
    end

    describe'#administer_road_test' do
      
    end

  end

  describe'#renew_drivers_license' do
    
  end
end
