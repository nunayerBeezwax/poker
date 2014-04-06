require 'spec_helper'

describe 'Table' do
	describe '#initialize' do
		it 'sets up a new table instance with X number of players, and an empty array for community cards' do
			test_table = Table.new(9)
			test_table.players.length.should eq 9
			test_table.should be_an_instance_of Table
			test_table.players[0].should be_an_instance_of Player
			test_table.players[2].chips.should eq 1000
			test_table.board.should eq []
		end
	end

	describe '#pot' do
		it 'starts at zero, and goes up as people deposit chips' do
			table = Table.new(9)
			table.pot.should eq 0
			table.players[5].raise(100)
			table.pot.should eq 100
			table.players[5].chips.should eq 900
			table.players[3].raise(225)
			table.pot.should eq 325
			table.players[3].chips.should eq 775
		end
	end

	describe '#button' do
		it 'starts at a random place on a table and increments(wrapping) each hand' do
			test_game = Game.new
			test_game.table.button.should be_between(1, 9)
			button1 = test_game.table.button
			test_game.hand
			test_game.table.button.to_s.should match(/#{button1+1}|1/)
		end
	end	

	describe '#action' do
		####### This is not currently doing much, need more thorough testing
		it 'beginning with button+1, asks each player still in the hand to make a decision' do
			test_game = Game.new
			test_game.table.dealer.preflop
			test_game.table.pot.should > 0
		end
	end

	describe '#active_players' do
		it 'returns an array of non-folded players at a given time, with their hands' do
			table = Table.new(9)
			table.dealer.preflop
			table.dealer.first_to_act
			9.times{table.dealer.action_driver}
			table.active_players.count.should < 7
			table.active_players[0].hole_cards.count.should eq 2
		end
	end

	describe '#small_blind' do
		it 'charges a fixed bet to the 1st position after button before each hand' do
			test_table = Table.new(9)
			test_table.dealer.preflop
			test_table.players.any?{|p| p.chips == 975}.should eq true
			test_table.pot.should eq 75
		end
	end

	describe '#big_blind' do
		it 'charges a fixed bet to the 2nd position after button before each hand' do
			test_table = Table.new(9)
			test_table.dealer.preflop
			test_table.pot.should eq 75
			test_table.players.any?{|p| p.chips == 950}.should eq true
		end
	end

	describe '#blinds' do
		it 'sets the values of the blinds based on hand number (for now...maybe timer)' do
			test_table = Table.new(9)
			test_table.blinds(3)
			test_table.bb.should eq 200
			test_table.sb.should eq 100
			test_table.pot.should eq 300
		end
	end
end


	# describe '#showdown' do
		##### Needs complete rethinking
		# it 'collects all remaining players hands into an array' do
		# 	test_game = Game.new
		# 	test_game.dealer.preflop
		# 	test_game.dealer.flop
		# 	test_game.dealer.turn
		# 	test_game.dealer.river
		# 	test_game.table.showdown
		# 	test_game.table.showdown.length.should eq 9
		# end
	# end