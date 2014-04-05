require 'spec_helper'

describe 'Dealer' do
before do
	Dealer.clear
end

	describe '#initialize' do
		it 'makes and shuffles a deck from which to deal random cards' do
			test_game = Game.new
			test_game.dealer.deck.cards.length.should eq 52
			test_game.dealer.deck.cards[33].should be_an_instance_of Card
		end
	end

	describe '#preflop' do
		it 'removes cards from the deck, gameing 2 cards to each player' do
			test_game = Game.new
			test_game.dealer.preflop
			test_game.table.players[5].hole_cards.length.should eq 2
			test_game.table.players[8].hole_cards.length.should eq 2
			test_game.table.players[0].hole_cards.length.should eq 2
			test_game.dealer.deck.cards.length.should eq 34
		end
	end

	describe '#flop' do
		it 'removes 3 cards from the deck and displays them as community cards' do
			test_game = Game.new
			test_game.dealer.preflop
			test_game.dealer.flop
			test_game.table.board.length.should eq 3
			test_game.table.board[1].should be_an_instance_of Card
			test_game.dealer.deck.cards.length.should eq 31
		end
	end

	describe '#turn and #river' do
		it 'each when called adds one more card to the community cards' do
			test_game = Game.new
			test_game.dealer.preflop
			test_game.dealer.flop
			test_game.dealer.turn
			test_game.table.board.length.should eq 4
			test_game.dealer.river
			test_game.table.board.length.should eq 5
		end
	end
end