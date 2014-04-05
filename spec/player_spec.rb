require 'spec_helper'

describe 'Player' do
	describe '#initialize' do
		it 'sets up a new player with a chip stack and an empty hole_cards array' do
			test_player = Player.new(1, 1000)
			test_player.hole_cards.should eq []
			test_player.seat.should eq 1
			test_player.chips.should eq 1000
			test_player.should be_an_instance_of Player
		end
	end
	describe '#combine' do
		it 'combines the hole cards with the community cards into a Hand object attached to that player' do
			test_game = Game.new
			test_game.dealer.preflop
			test_game.dealer.flop
			test_game.dealer.turn
			test_game.dealer.river
			test_game.table.showdown
			test_game.table.hands.length.should eq 9
			test_game.table.hands[3].hand.length.should eq 7
			test_game.table.hands[7].should be_an_instance_of Hand
			test_game.table.hands[5].player.should eq 6
		end
	end

	describe '#decision' do
		it 'passes info to the brain and reports a decision' do
			test_player = Player.new(1, 1000)
			card1 = Card.new('H', 8)
			card2 = Card.new('H', 7)
			test_player.get_card(card1)
			test_player.get_card(card2)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Call'
			test_player.chips.should eq 900
		end

		it 'doesn\'t always call' do
			test_player = Player.new(1, 1000)
			card1 = Card.new('H', 13)
			card2 = Card.new('C', 5)
			test_player.get_card(card1)
			test_player.get_card(card2)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Fold'
			test_player.hole_cards.should eq []
		end

		it 'is capable of raising' do
			test_player = Player.new(1, 1000)
			card1 = Card.new('H', 13)
			card2 = Card.new('S', 13)
			test_player.get_card(card1)
			test_player.get_card(card2)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Raise'
			test_player.chips.should eq 700
		end
	end
end