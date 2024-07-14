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
        @test_car = @wa_ev_registrations[0]
    end

        describe '#initialize' do
            it 'will create a vehicle_details object with all nil values(excludes engine:)' do
                expect(@factory.vehicle_details).to eq({:vin => nil, :year => nil, :make => nil, :model => nil, :engine => :ev, :plate_type => nil, :registration_date => nil})
            end

            it 'will create a vehicles array to store vehicle instances' do
                expect(@factory.vehicles).to be_an_instance_of Array
            end
        end

        describe '#transform_vehicle_data' do
            it 'will create a new Vehicle object' do
                @factory.transform_vehicle_data(@test_car)

                expect(@factory.vehicles[0]).to be_an_instance_of Vehicle
            end

            it 'will apply relevant key value pairs to Vehicle object as argument for vehicle details' do
                @factory.transform_vehicle_data(@test_car)

                expect(@factory.vehicles[0].vin).to eq '3C3CFFGE5F'
                expect(@factory.vehicles[0].year).to eq '2015'
                expect(@factory.vehicles[0].make).to eq 'FIAT'
                expect(@factory.vehicles[0].model).to eq '500'
                expect(@factory.vehicles[0].engine).to eq :ev
                expect(@factory.vehicles[0].plate_type).to eq nil
                expect(@factory.vehicles[0].registration_date).to eq nil
            end

            it 'will push the vehicle instance into the vehicle array' do
                expect{@factory.transform_vehicle_data(@test_car)}.to change{@factory.vehicles.length}.from(0).to(1)
            end
        end
        describe '#create_vehicles' do
            it 'will push vehicles to the vehicles array using the #transform_vehicle_data helper method' do 
                expect{@factory.create_vehicles(@wa_ev_registrations)}.to change{@factory.vehicles.length}.from(0).to(1000)
            end
        end
end
