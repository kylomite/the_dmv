require 'spec_helper'
require './lib/facility_factory'
require './lib/dmv_data_service'

RSpec.configure do |config|
    config.formatter = :documentation
end

RSpec.describe Facility_Factory do
    before(:each) do
        @co_facilities = DmvDataService.new.co_dmv_office_locations
        @ny_facilities = DmvDataService.new.ny_dmv_office_locations
        @mo_facilities = DmvDataService.new.mo_dmv_office_locations
        @dmv = Facility_Factory.new
        @co_test_facility = @co_facilities[0]
        @ny_test_facility = @ny_facilities[0]
        @mo_test_facility = @mo_facilities[0]
    end
    
    describe '#initialize' do
        it 'will create an array of faciltiy_details object templates with default values' do
            expect(@dmv.facility_details).to eq({:name => nil, :address => nil, :phone => nil, :services => [], :registered_vehicles => [], :collected_fees => 0})
        end

        it 'will create an object to store facility instances for each state' do
            expect(@dmv.facilities).to eq({:co => [], :ny => [], :mo => []})
        end
    end

    describe '#create facilities' do
        it 'will push facilities to the appropriate state array using the #transform_facility_data helper method' do
            #expect{@dmv.create_facilities(@co_facilities)}.to change{@dmv.facilities[:co].length}.from(0).to(5)
            expect{@dmv.create_facilities(@ny_facilities)}.to change{@dmv.facilities[:ny].length}.from(0).to(170)
            expect{@dmv.create_facilities(@mo_facilities)}.to change{@dmv.facilities[:mo].length}.from(0).to(178)
        end
    end
#COLORADO
    # describe '#transform_co_facility_data' do
    #     it 'will create a new Facility object' do
    #         @dmv.transform_co_facility_data(@co_test_facility)

    #             expect(@dmv.facilities[:co][0]).to be_an_instance_of Facility
    #     end

    #     it 'will apply relevant key value pairs to Facility object as argument for facility details' do
    #         @dmv.transform_co_facility_data(@co_test_facility)

    #             expect(@dmv.facilities[:co][0].name).to eq 'DMV Tremont Branch'
    #             expect(@dmv.facilities[:co][0].address).to eq '2855 Tremont Place'
    #             expect(@dmv.facilities[:co][0].phone).to eq '(720) 865-4600'
    #             expect(@dmv.facilities[:co][0].services).to eq []
    #             expect(@dmv.facilities[:co][0].registered_vehicles).to eq []
    #             expect(@dmv.facilities[:co][0].collected_fees).to eq 0
    #     end

    #     it 'will push the facility instance into the facilitys state array' do
    #         expect{@dmv.transform_co_facility_data(@co_test_facility)}.to change{@dmv.facilities[:co].length}.from(0).to(1)
    #     end
    # end
# #NEW YORK
       describe '#transform_ny_facility_data' do
        it 'will create a new Facility object' do
            @dmv.transform_ny_facility_data(@ny_test_facility)

                expect(@dmv.facilities[:ny][0]).to be_an_instance_of Facility
        end

        it 'will apply relevant key value pairs to Facility object as argument for facility details' do
            @dmv.transform_ny_facility_data(@ny_test_facility)

                expect(@dmv.facilities[:ny][0].name).to eq 'HUNTINGTON'
                expect(@dmv.facilities[:ny][0].address).to eq '1815 E JERICHO TURNPIKE'
                expect(@dmv.facilities[:ny][0].phone).to eq '7184774820'
                expect(@dmv.facilities[:ny][0].services).to eq []
                expect(@dmv.facilities[:ny][0].registered_vehicles).to eq []
                expect(@dmv.facilities[:ny][0].collected_fees).to eq 0
        end

        it 'will push the facility instance into the facilitys state array' do
            expect{@dmv.transform_ny_facility_data(@ny_test_facility)}.to change{@dmv.facilities[:ny].length}.from(0).to(1)
        end
    end
# #MISSOURI
    describe '#transform_mo_facility_data' do
        it 'will create a new Facility object' do
            @dmv.transform_mo_facility_data(@mo_test_facility)

                expect(@dmv.facilities[:mo][0]).to be_an_instance_of Facility
        end

        it 'will apply relevant key value pairs to Facility object as argument for facility details' do
            @dmv.transform_mo_facility_data(@mo_test_facility)

                expect(@dmv.facilities[:mo][0].name).to eq 'FERGUSON-OFFICE CLOSED UNTIL FURTHER NOTICE'
                expect(@dmv.facilities[:mo][0].address).to eq '10425 WEST FLORISSANT'
                expect(@dmv.facilities[:mo][0].phone).to eq '(314) 733-5316'
                expect(@dmv.facilities[:mo][0].services).to eq []
                expect(@dmv.facilities[:mo][0].registered_vehicles).to eq []
                expect(@dmv.facilities[:mo][0].collected_fees).to eq 0
        end

        it 'will push the facility instance into the facilitys state array' do
            expect{@dmv.transform_mo_facility_data(@mo_test_facility)}.to change{@dmv.facilities[:mo].length}.from(0).to(1)
        end
    end
end
