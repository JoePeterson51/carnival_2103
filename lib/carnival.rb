class Carnival
  attr_reader :name, :rides, :attendees
  def initialize(name)
    @name = name
    @rides = []
    @attendees = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def recommend_rides(attendee)
    @rides.flat_map do |ride|
      attendee.interests.flat_map do |interest|
        if ride.name == interest
          ride
        end
      end.compact
    end
  end

  def admit(attendee)
    @attendees << attendee
  end

  def attendees_by_ride_interest
    attendees_by_ride_interest = {}
    @rides.map do |ride|
      attendees_by_ride_interest[ride] = []
    end
    attendees_by_ride_interest.group_by do |ride, attendee|
      @attendees.map do |attendee|
        if attendee.interests.include?(ride.name)
          attendees_by_ride_interest[ride] << attendee
        end
      end
    end
    attendees_by_ride_interest
  end

  def ticket_lottery_contestants(ride)
    @attendees.find_all do |attendee|
      attendee.spending_money < ride.cost
    end
  end

  def draw_lottery_winner(ride)
    contestants = ticket_lottery_contestants(ride)
    contestants.sample
  end

  def announce_lottery_winner(ride)
    if ticket_lottery_contestants(ride).count == 0
      return "No winners"
    end
    contestants = ticket_lottery_contestants(ride)
    winner = contestants.sample
    winner
  end
end