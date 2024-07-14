require 'spec_helper'
require './lib/facility_factory'
require './lib/dmv_data_service'

RSpec.configure do |config|
    config.formatter = :documentation
end

RSpec.describe Facility_Factory do
    before(:each) do
        @dmv = Facility_Factory.new
        @co_facilities = DmvDataService.new.co_dmv_office_locations
        @ny_facilities = DmvDataService.new.ny_dmv_office_locations
        @mo_facilities = DmvDataService.new.mo_dmv_office_locations
    end
    
    describe '#initialize' do
        it 'will create an array of faciltiy_details object templates with default values for each state' do
            expect(@dmv.facility_details[0]).to eq({:name => nil, :address => nil, :phone => nil, :services => [], :registered_vehicles => [], :collected_fees => 0})
        end

        it 'will create an object to store facility instances for each state' do
            expect(@dmv.facilites).to eq({:co => [], :ny => [], :mo => []})
        end
    end

    describe '#transform_co_facility_data' do

    end

    describe 'create_co_facilities' do
        
    end

    describe '#transform_ny_facility_data' do

    end

    describe 'create_ny_facilities' do

    end

    describe '#transform_mo_facility_data' do

    end

    describe 'create_mo_facilities' do

    end
end