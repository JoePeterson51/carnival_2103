require './lib/carnival'
require './lib/attendee'
require './lib/ride'

describe Carnival do
  it 'exists' do
    jeffco_fair = Carnival.new("Jefferson County Fair")

    expect(jeffco_fair).to be_a(Carnival)
  end

  it 'has attributes' do
    jeffco_fair = Carnival.new("Jefferson County Fair")

    expect(jeffco_fair.name).to eq("Jefferson County Fair")
    expect(jeffco_fair.rides).to eq([])
  end

  describe '#add_ride' do
    it 'can add rides' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      expect(jeffco_fair.rides).to eq([ferris_wheel, bumper_cars, scrambler])
    end
  end

  describe '#recommend_rides' do
    it 'can recomment rides based on interests' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      bob = Attendee.new('Bob', 20)
      sally = Attendee.new('Sally', 20)

      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Scrambler')

      expect(jeffco_fair.recommend_rides(bob)).to eq([ferris_wheel, bumper_cars])
      expect(jeffco_fair.recommend_rides(sally)).to eq([scrambler])
    end

    describe '#admit' do
      it 'has no attendees by default' do
        jeffco_fair = Carnival.new("Jefferson County Fair")
        ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
        bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
        scrambler = Ride.new({name: 'Scrambler', cost: 15})

        jeffco_fair.add_ride(ferris_wheel)
        jeffco_fair.add_ride(bumper_cars)
        jeffco_fair.add_ride(scrambler)

        expect(jeffco_fair.attendees).to eq([])
      end

      it 'can add attendees' do
        jeffco_fair = Carnival.new("Jefferson County Fair")
        ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
        bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
        scrambler = Ride.new({name: 'Scrambler', cost: 15})

        jeffco_fair.add_ride(ferris_wheel)
        jeffco_fair.add_ride(bumper_cars)
        jeffco_fair.add_ride(scrambler)

        bob = Attendee.new("Bob", 0)
        bob.add_interest('Ferris Wheel')
        bob.add_interest('Bumper Cars')

        sally = Attendee.new('Sally', 20)
        sally.add_interest('Bumper Cars')

        johnny = Attendee.new("Johnny", 5)
        johnny.add_interest('Bumper Cars')

        jeffco_fair.admit(bob)
        jeffco_fair.admit(sally)
        jeffco_fair.admit(johnny)

        expect(jeffco_fair.attendees).to eq([bob, sally, johnny])
      end
    end

    describe '#attendees_by_ride_interest' do
      it 'can sort attendees by ride interest' do
        jeffco_fair = Carnival.new("Jefferson County Fair")
        ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
        bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
        scrambler = Ride.new({name: 'Scrambler', cost: 15})

        jeffco_fair.add_ride(ferris_wheel)
        jeffco_fair.add_ride(bumper_cars)
        jeffco_fair.add_ride(scrambler)

        bob = Attendee.new("Bob", 0)
        bob.add_interest('Ferris Wheel')
        bob.add_interest('Bumper Cars')

        sally = Attendee.new('Sally', 20)
        sally.add_interest('Bumper Cars')

        johnny = Attendee.new("Johnny", 5)
        johnny.add_interest('Bumper Cars')

        jeffco_fair.admit(bob)
        jeffco_fair.admit(sally)
        jeffco_fair.admit(johnny)

        expect(jeffco_fair.attendees_by_ride_interest).to eq({
          ferris_wheel => [bob],
          bumper_cars => [bob, sally, johnny],
          scrambler => []
          })
      end
    end

    describe '#ticket_lottery_contestants' do
      it 'can enter attendees into lottery who cant afford ride' do
        jeffco_fair = Carnival.new("Jefferson County Fair")
        ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
        bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
        scrambler = Ride.new({name: 'Scrambler', cost: 15})

        jeffco_fair.add_ride(ferris_wheel)
        jeffco_fair.add_ride(bumper_cars)
        jeffco_fair.add_ride(scrambler)

        bob = Attendee.new("Bob", 0)
        bob.add_interest('Ferris Wheel')
        bob.add_interest('Bumper Cars')

        sally = Attendee.new('Sally', 20)
        sally.add_interest('Bumper Cars')

        johnny = Attendee.new("Johnny", 5)
        johnny.add_interest('Bumper Cars')

        jeffco_fair.admit(bob)
        jeffco_fair.admit(sally)
        jeffco_fair.admit(johnny)

        expect(jeffco_fair.ticket_lottery_contestants(bumper_cars)).to eq([bob, johnny])
      end
    end

    describe '#draw_lottery_winner' do
      it 'can draw a random winner for ride' do
        jeffco_fair = Carnival.new("Jefferson County Fair")
        ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
        bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
        scrambler = Ride.new({name: 'Scrambler', cost: 15})

        jeffco_fair.add_ride(ferris_wheel)
        jeffco_fair.add_ride(bumper_cars)
        jeffco_fair.add_ride(scrambler)

        bob = Attendee.new("Bob", 0)
        bob.add_interest('Ferris Wheel')
        bob.add_interest('Bumper Cars')

        sally = Attendee.new('Sally', 20)
        sally.add_interest('Bumper Cars')

        johnny = Attendee.new("Johnny", 5)
        johnny.add_interest('Bumper Cars')

        jeffco_fair.admit(bob)
        jeffco_fair.admit(sally)
        jeffco_fair.admit(johnny)

        allow(jeffco_fair).to receive(:draw_lottery_winner) do
          bob
        end

        expect(jeffco_fair.draw_lottery_winner(bumper_cars)).to eq(bob)
      end
    end

    describe '#announce_lottery_winner' do
      it 'can announce lottery winner' do
        jeffco_fair = Carnival.new("Jefferson County Fair")
        ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
        bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
        scrambler = Ride.new({name: 'Scrambler', cost: 15})

        jeffco_fair.add_ride(ferris_wheel)
        jeffco_fair.add_ride(bumper_cars)
        jeffco_fair.add_ride(scrambler)

        bob = Attendee.new("Bob", 0)
        bob.add_interest('Ferris Wheel')
        bob.add_interest('Bumper Cars')

        sally = Attendee.new('Sally', 20)
        sally.add_interest('Bumper Cars')

        johnny = Attendee.new("Johnny", 5)
        johnny.add_interest('Bumper Cars')

        jeffco_fair.admit(bob)
        jeffco_fair.admit(sally)
        jeffco_fair.admit(johnny)

        allow(jeffco_fair).to receive(:announce_lottery_winner) do
          bob
        end

        expect(jeffco_fair.announce_lottery_winner(scrambler)).to eq(bob)
      end

      it 'returns no winner if no contestants' do
        jeffco_fair = Carnival.new("Jefferson County Fair")
        ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
        bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
        scrambler = Ride.new({name: 'Scrambler', cost: 15})

        jeffco_fair.add_ride(ferris_wheel)
        jeffco_fair.add_ride(bumper_cars)
        jeffco_fair.add_ride(scrambler)

        bob = Attendee.new("Bob", 0)
        bob.add_interest('Ferris Wheel')
        bob.add_interest('Bumper Cars')

        sally = Attendee.new('Sally', 20)
        sally.add_interest('Bumper Cars')

        johnny = Attendee.new("Johnny", 5)
        johnny.add_interest('Bumper Cars')

        jeffco_fair.admit(bob)
        jeffco_fair.admit(sally)
        jeffco_fair.admit(johnny)

        expect(jeffco_fair.announce_lottery_winner(ferris_wheel)).to eq("No winners")
      end
    end
  end
end