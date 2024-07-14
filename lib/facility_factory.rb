require './lib/dmv_data_service'
require './lib/facility'


class Facility_Factory 
    attr_accessor :facility_details, 
                  :facilites

    def initialize 
        @facility_details = [
            {:name => nil, :address => nil, :phone => nil, :services => [], :registered_vehicles => [], :collected_fees => 0},
            {:name => nil, :address => nil, :phone => nil, :services => [], :registered_vehicles => [], :collected_fees => 0},
            {:name => nil, :address => nil, :phone => nil, :services => [], :registered_vehicles => [], :collected_fees => 0}
        ]
        @facilites = {
            :co => [],
            :ny => [],
            :mo => []
        }
    end
end