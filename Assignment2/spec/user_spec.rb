require_relative '../carCleaningService'

describe User do
  let(:car) { Car.new("CJ 12 AAA") }
  let(:user) { User.new(car, "UserName", Time.now) }

  describe '.set_pick_up_time' do
    it 'sets a pick up time after the current one' do
      result = user.set_pick_up_time

      expect(result).to be >= Time.now
    end
  end
end
