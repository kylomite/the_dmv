class Facility
  attr_reader :name, :address, :phone, :services

  def initialize(fac_info)
    @name = fac_info[:name]
    @address = fac_info[:address]
    @phone = fac_info[:phone]
    @services = []
  end

  def add_service(service)
    @services << service
  end
end
