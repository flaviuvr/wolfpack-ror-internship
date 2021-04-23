require_relative '../carCleaningService'

describe Service do
  let(:car) { Car.new('CJ 12 AAA') }
  let(:user) { User.new('UserName', car, Time.now) }
  let(:station) { Station.new('Station') }
  subject { Service.new }

  describe '.add_new_client' do

    it 'adds client to queue' do
      subject.add_new_client(user)

      expect(subject.clients[user].license_plate_number).to eq 'CJ 12 AAA'
    end
  end

  describe '.clean_car_in_station' do

    it 'cleans car present in station' do
      subject.add_new_client(user)
      subject.clean_car_in_station(station, user)

      expect(subject.clients).to eq({})
    end

    it 'notifies client when done' do
      subject.add_new_client(user)
      subject.clean_car_in_station(station, user)

      expect(user.time_of_pickup).to be >= Time.now
    end
  end
end

