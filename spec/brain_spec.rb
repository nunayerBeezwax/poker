require 'spec_helper'

describe Brain do
	describe '#draw' do
		it 'computes the odds of making a hand' do
			test_game = Game.new
			hole_card1 = Card.new('H', 10)
			hole_card2 = Card.new('H', 11)
			board_card1 = Card.new('H', 5)
			board_card2 = Card.new('H', 2)
			board_card3 = Card.new('C', 13)
			player = test_game.table.players[0]
			board = test_game.table.board
			player.hole_cards << hole_card1
			player.hole_cards << hole_card2
			board << board_card1
			board << board_card2
			board << board_card3
			hand = Hand.new(player.combine(board), player)
			player.brain.draw(hand, 'flop')
			player.brain.odds['flush'].should be_within(0.005).of(0.3496)
		end
	end

	describe '#prefop' do
		it 'doesn\'t always call' do
			test_player = Player.new(1, 1000)
			test_player.hole_cards << Card.new('H', 10)
			test_player.hole_cards << Card.new('D', 9)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Fold'
		end
		it 'raises with any pair' do
			test_player = Player.new(1, 1000)
			test_player.hole_cards << Card.new('H', 10)
			test_player.hole_cards << Card.new('D', 10)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Raise'
		end
		it 'calls with any suited ace' do
			test_player = Player.new(1, 1000)
			test_player.hole_cards << Card.new('H', 14)
			test_player.hole_cards << Card.new('H', 4)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Call'
		end
		it 'calls with two high cards' do
			test_player = Player.new(1, 1000)
			test_player.hole_cards << Card.new('S', 12)
			test_player.hole_cards << Card.new('D', 13)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Call'
		end
		it 'calls with suited connectors' do
			test_player = Player.new(1, 1000)
			test_player.hole_cards << Card.new('D', 5)
			test_player.hole_cards << Card.new('D', 6)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Call'	
		end
		it 'calls with any suited ace' do
			test_player = Player.new(1, 1000)
			test_player.hole_cards << Card.new('D', 5)
			test_player.hole_cards << Card.new('D', 14)
			hand = test_player.combine([])
			test_player.decision(hand, 100).should eq 'Call'	
		end
	end
end