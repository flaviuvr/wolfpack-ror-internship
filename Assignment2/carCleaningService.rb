
class User
  attr_reader :name, :car, :time_of_arrival, :time_of_pickup

  include Schedule

  def initialize(name, car, time_of_arrival)
    @name = name
    @car = car
    @time_of_arrival = time_of_arrival
  end

  def update
    puts "#{@name} was notified"
    puts "#{@name} will be there #{@time_of_pickup}"

    set_pick_up_time
  end

  def set_pick_up_time
    # Sets a random time after the current one (in MINUTES)
    # @time_of_pickup = Time.new + rand(1..10) * 10 * 60

    # Sets a random time after the current one (in SECONDS)
    @time_of_pickup = Time.new + rand(1..10)

    remaining_time = @time_of_pickup - Time.new
    remaining_time.round
  end

  def pick_up_car
    set_pick_up_time
    remaining_time = @time_of_pickup - Time.new
    remaining_time.round
  end
end

class Car
  attr_reader :license_plate_number, :in_station

  def initialize(license_plate_number)
    @license_plate_number = license_plate_number
    @in_station = false
  end

end