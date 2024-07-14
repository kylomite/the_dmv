require 'spec_helper'
require './lib/vehicle_factory'
require './lib/dmv_data_service'

RSpec.configure do |config|
    config.formatter = :documentation
end
  
RSpec.describe VehicleFactory do
    before(:each) do
        @factory = VehicleFactory.new
        @wa_ev_registrations = DmvDataService.new.wa_ev_registrations    
        @factory.transform_vehicle_data(@wa_ev_registrations[0])
    end

    describe '#transform_vehicle_data' do

        it 'will create a new Vehicle object' do
            expect(@factory.transform_vehicle_data(@wa_ev_registrations[0])).to be_an_instance_of Vehicle
        end

        it 'will convert relevant API object key value pairs to object for Vehicle class' do
            @factory.transform_vehicle_data(@wa_ev_registrations[0])

            expect(@wa_ev_registrations[0].vehicle_details).to eq {vin: '3C3CFFGE5F', year: 2015, make: 'FIAT', model: '500', engine: :ev, plate_type: nil, registration_date: nil}
        end

        it 'will apply key value pairs to Vehicle object as argument for instantiation' do
            expect(@wa_ev_registrations[0].vin).to eq '3C3CFFGE5F'
            expect(@wa_ev_registrations[0].year).to eq 2015
            expect(@wa_ev_registrations[0].make).to eq 'FIAT'
            expect(@wa_ev_registrations[0].model).to eq '500'
            expect(@wa_ev_registrations[0].engine).to eq :ev
            expect(@wa_ev_registrations[0].plate_type).to eq nil
            expect(@wa_ev_registrations[0].registration_date).to eq nil
        end
    end

    describe '#create_vehicles' do

        it 'will push vehicles to the vehicles array using the #transform_vehicle_data helper method' do 

        end
    end
    

end
