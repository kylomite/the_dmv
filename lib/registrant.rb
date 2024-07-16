class Registrant
    attr_reader :name,
                :age,
                :permit
                
    attr_accessor :license_data

    def initialize(name, age, permit = false)
        if name.class != String
            @name = "Default Text"
        elsif age.class != Integer
            @age = 0
        else
            @name = name
            @age = age
            @permit = permit
            @license_data = {:written=>false, :license=>false, :renewed=>false}
        end
    end

    def earn_permit
        if @permit == false && @age > 15
            @permit = true
        end
    end

    def permit?
        @permit
    end
end