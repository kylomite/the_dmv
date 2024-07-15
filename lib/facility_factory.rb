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
    
    def create_facilities(facilities_list)
        if facilities_list[0][:state] == "CO"
            facilities_list.each {|facility|
            transform_co_facility_data(facility)
            }
        elsif facilities_list[0][:state] == "NY"
            facilities_list.each {|facility|
            transform_ny_facility_data(facility)
            }
        else facilities_list[0][:state] == "MO"
            facilities_list.each {|facility|
            transform_mo_facility_data(facility)
            }
        end
    end
#COLORADO
    def transform_co_facility_data(facility)
        @facility_details [:name] = facility[:dmv_office]
        @facility_details [:address] = facility[:address_li]
        @facility_details [:phone] = facility[:phone]
        @facilities[:co].push(Facility.new(@facility_details))    
    end
#NEW YORK
    def transform_ny_facility_data(facility)
        @facility_details [:name] = facility[:office_name]
        @facility_details [:address] = facility[:street_address_line_1]
        @facility_details [:phone] = facility[:public_phone_number]
        @facilities[:ny].push(Facility.new(@facility_details))    
    end
#MISSOURI
    def transform_mo_facility_data(facility)
        @facility_details [:name] = facility[:name]
        @facility_details [:address] = facility[:address1]
        @facility_details [:phone] = facility[:phone]
        @facilities[:mo].push(Facility.new(@facility_details))    
    end
end