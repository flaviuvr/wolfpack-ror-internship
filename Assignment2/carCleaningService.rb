require 'time'

# Describes the schedule by which the service operates
module Schedule
  START_TIME_HOUR = 8
  END_TIME_HOUR = 17

  def self.open?(time)
    open_time?(time) && open_day?(time)
  end

  def self.open_time?(current_time)
    current_time.hour > START_TIME_HOUR && current_time.hour < END_TIME_HOUR
  end

  def self.open_day?(current_day_of_week)
    !(current_day_of_week.saturday? || current_day_of_week.sunday?)
  end
end

# Clients of the car wash service. Will be updated once their car is ready for pick up and then pick a time to come for it
class User
  attr_reader :name, :car, :time_of_arrival, :time_of_pickup

  def initialize(name, car, time_of_arrival)
    @name = name
    @car = car
    @time_of_arrival = time_of_arrival
  end

  def notify
    puts "#{name} was notified"
    set_pick_up_time
    puts "#{name} will be there to pick car up #{@time_of_pickup}"
  end

  def set_pick_up_time
    # Sets a random time after the current one (in HOURS)
    @time_of_pickup = Time.new + rand(1..100) * 10 * 60 * 60

    Schedule.open?(@time_of_pickup) ? @time_of_pickup : set_pick_up_time
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
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def clean_car(car)
    puts "Now cleaning car #{car.license_plate_number} on #{name}"
    puts "Done cleaning car #{car.license_plate_number} on #{name}"
  end
end

# The working service that handles the added cars and notifies the users
class Service
  attr_accessor :clients, :station1, :station2

  def initialize
    @clients = {}
    @station1 = Station.new('Station 1')
    @station2 = Station.new('Station 2')
  end

  def add_new_client(client)
    @clients[client] = client.car
    puts "#{client.name} came in at #{client.time_of_arrival} with car #{client.car.license_plate_number}"
  end

  def notify_client(client)
    client&.notify
  end

  def move_to_station(client1, client2)
    car1 = @clients[client1]
    car2 = @clients[client2]

    @station1.clean_car(car1)
    notify_client(client1)
    @clients.delete(client1)

    unless client2.nil?
      @station2.clean_car(car2)
      notify_client(client2)
      @clients.delete(client2)
    end
  end

  def work
    # This can be commented to see the functionality from outside working hours
    return unless Schedule.open?(Time.now)

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
service.add_new_client(user1)
service.add_new_client(user2)
service.add_new_client(user3)
service.add_new_client(user4)
service.add_new_client(user5)
service.add_new_client(user6)

service.work
