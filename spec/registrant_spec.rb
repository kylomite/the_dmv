require 'rspec'
require './lib/registrant'


RSpec.configure do |config|
    config.formatter = :documentation
    end

RSpec.describe 'registrant' do

    before(:each) do
        @registrant_1 = Registrant.new('Bruce', 18, true )
        @registrant_2 = Registrant.new('Penny', 15 )
        @registrant_3 = Registrant.new('Kaizen', 17 )
    end

    describe '#initialize' do
        it 'should exist' do
            expect(@registrant_1).to be_an_instance_of Registrant
        end

        it 'should have a name' do
            expect(@registrant_1.name).to eq 'Bruce'
        end

        it 'should have an age' do
            expect(@registrant_1.age).to eq 18
        end

        it 'should default to not have a permit' do
            expect(@registrant_2.permit).to be false
        end

        it 'should be able to have a permit if specificed' do
            expect(@registrant_1.permit).to be true
        end

        it 'should default to have license data without any true values' do
            expect(@registrant_1.license_data).to include({:written => false, :license => false, :renewed => false})
        end
    end

    describe '#earn_permit' do
        it 'should update the permit atttribute' do
            expect{@registrant_3.earn_permit}.to change{@registrant_3.permit}.from(false).to(true)
        end

        it 'should be inaccesable to someone who has already earned their permit' do
            expect{@registrant_1.earn_permit}.not_to change{@registrant_1.permit}
        end

        it 'should be inaccesable to someone who is younger than 16' do
            expect{@registrant_2.earn_permit}.not_to change{@registrant_2.permit}
        end
    end

    describe '#permit?' do
        it 'should return wether or not individual has a permit' do
            expect(@registrant_1.permit?).to be true
        end
    end
end