require 'time'

# Describes the schedule by which the service operates
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

# Clients of the car wash service. Will be updated once their car is ready for pick up and then pick a time to come for it
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
    set_pick_up_time
    puts "#{@name} will be there to pick car up #{@time_of_pickup}"
  end

  def set_pick_up_time
    # Sets a random time after the current one (in HOURS)
    @time_of_pickup = Time.new + rand(1..100) * 10 * 60 * 60
    # Check if the set time is in conformity with the schedule of the car wash
    if Schedule.open?(@time_of_pickup)
      @time_of_pickup
    else
      set_pick_up_time
    end
  end
end

# Describes the identifier of each car, their license plate number
class Car
  attr_reader :license_plate_number

  def initialize(license_plate_number)
    @license_plate_number = license_plate_number
  end
end

# Handles the actual cleaning of the cars
class Station
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def clean_car(car)
    puts "Now cleaning car #{car.license_plate_number} on #{name}" unless car.nil?
    puts "Done cleaning car #{car.license_plate_number} on #{name}" unless car.nil?
  end
end

# The working service that handles the added cars and notifies the users
class Service
  attr_accessor :clients, :station1, :station2

  include Schedule

  def initialize
    @clients = {}
    @station1 = Station.new('Station 1')
    @station2 = Station.new('Station 2')
  end

  def add_new_car(user)
    @clients[user] = user.car
    puts "#{user.name} came in at #{user.time_of_arrival} with car #{user.car.license_plate_number}"
  end

  def notify(client)
    client&.update
  end

  def move_to_station(client1, client2)
    car1 = @clients[client1]
    car2 = @clients[client2]

    @station1.clean_car(car1)
    notify(client1)
    @clients.delete(client1)

    unless client2.nil?
      @station2.clean_car(car2)
      notify(client2)
      @clients.delete(client2)
    end

  end

  def work
    # This can be commented to see the functionality from outside working hours
    # return unless Schedule.open?(Time.now)

    move_to_station(@clients.keys[0], @clients.keys[1]) until @clients == {}
  end
end

# Test data
bmw = Car.new('CJ 93 RIF')
vw = Car.new('CJ 72 RIF')
ford = Car.new('B 113 PBD')
toy = Car.new('B 12 AAA')
audi = Car.new('CJ 11 AUD')
alfa = Car.new('CJ 11 ALF')

user1 = User.new('Flaviu', bmw, Time.new)
user2 = User.new('Ionut', vw, Time.new)
user3 = User.new('Vlad', ford, Time.new)
user4 = User.new('Dan', toy, Time.new)
user5 = User.new('Alex', audi, Time.new)
user6 = User.new('Adi', alfa, Time.new)

service = Service.new
service.add_new_car(user1)
service.add_new_car(user2)
service.add_new_car(user3)
service.add_new_car(user4)
service.add_new_car(user5)
service.add_new_car(user6)

service.work
