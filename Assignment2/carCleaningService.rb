require 'time'

module Schedule
  START_WEEK_DAY = 1 # Monday
  END_WEEK_DAY = 5 # Friday
  START_TIME_HOUR = 8
  END_TIME_HOUR = 17

  def self.open?(time)
    open_time?(time) && open_day?(time)
  end

  def self.open_time?(current_time)
    current_time.hour > START_TIME_HOUR && current_time.hour < END_TIME_HOUR
  end

  def self.open_day?(current_day_of_week)
    current_day_of_week.wday > START_WEEK_DAY && current_day_of_week.wday < END_WEEK_DAY
  end
end

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

class Station
  attr_accessor :name, :busy

  def initialize(name)
    @name = name
    @busy = false
  end

  def start_clean(car)
    puts "Now cleaning car #{car.license_plate_number} on #{name}" unless car.nil?
    @busy = true
  end

  def end_clean(car)
    puts "Done cleaning car #{car.license_plate_number} on #{name}" unless car.nil?
  end

  def clean_car(car)
    start_clean(car)
    end_clean(car)
  end
end

