require './lib/dmv_data_service'
require './lib/facility'


class Facility_Factory 
    attr_accessor :facility_details, 
                  :facilities

    def initialize 
        @facility_details = {:name => nil, :address => nil, :phone => nil, :services => [], :registered_vehicles => [], :collected_fees => 0}
        @facilities = {
            :co => [],
            :ny => [],
            :mo => []
        }
    end

    def transform_co_facility_data(facility)
        @facility_details [:name] = facility[:dmv_office]
        @facility_details [:address] = facility[:address_li]
        @facility_details [:phone] = facility[:phone]
        @facilities[:co].push(Facility.new(@facility_details))    
    end

    def create_co_facilities(facilities_list)
        facilities_list.each {|facility|
        transform_co_facility_data(facility)
        }
        @facilities[0]
    end

    def transform_ny_facility_data(facility)
        @facility_details [:name] = facility[:office_name]
        @facility_details [:address] = facility[:street_address_line_1]
        @facility_details [:phone] = facility[:public_phone_number]
        @facilities[:ny].push(Facility.new(@facility_details))    
    end

    def create_ny_facilities(facilities_list)
        facilities_list.each {|facility|
        transform_ny_facility_data(facility)
        }
        @facilities[1]
    end
end