require 'spec_helper'

describe 'Dealer' do

	describe '#initialize' do
		it 'makes and shuffles a deck from which to deal random cards' do
			test_game = Game.new
			test_game.table.dealer.deck.cards.length.should eq 52
			test_game.table.dealer.deck.cards[33].should be_an_instance_of Card
		end
	end

	describe '#preflop' do
		it 'removes cards from the deck, gameing 2 cards to each player' do
			test_table = Table.new(9)
			test_table.dealer.preflop
			test_table.players[5].hole_cards.length.should eq 2
			test_table.players[8].hole_cards.length.should eq 2
			test_table.players[0].hole_cards.length.should eq 2
			test_table.dealer.deck.cards.length.should eq 34
		end
	end

	describe '#new_hand' do
		it 'Clears the board cards, empties the pot, moves the button,
		and shuffles up a new Deck for the next hand' do
		test_table = Table.new(9)
		button1 = test_table.button
		test_table.dealer.preflop
		test_table.dealer.flop
		test_table.dealer.new_hand
		test_table.board.should eq []
		test_table.pot.should eq 0
		test_table.button.should eq button1+1 || 0
		test_table.dealer.deck.cards.count.should eq 52
		end
	end

	describe '#flop' do
		it 'removes 3 cards from the deck and displays them as community cards' do
			test_table = Table.new(9)
			test_table.dealer.preflop
			test_table.dealer.flop
			test_table.board.length.should eq 3
			test_table.board[1].should be_an_instance_of Card
			test_table.dealer.deck.cards.length.should eq 31
		end
	end

	describe '#turn and #river' do
		it 'each when called adds one more card to the community cards' do
			test_table = Table.new(9)
			test_table.dealer.preflop
			test_table.dealer.flop
			test_table.dealer.turn
			test_table.board.length.should eq 4
			test_table.dealer.river
			test_table.board.length.should eq 5
		end
	end

	describe '#first_to_act' do
		it 'determines who acts first on any given action round' do
			test_table = Table.new(9)
			button = test_table.button
			if button <= 6
				test_table.dealer.first_to_act.should eq button + 3
			elsif button == 7
				test_table.dealer.first_to_act.should eq 1
			elsif button == 8
				test_table.dealer.first_to_act.should eq 2
			elsif button == 9
				test_table.dealer.first_to_act.should eq 3
			end
		end
	end

	describe '#action_driver' do
		it 'calls the player who has the action to make a decision' do
			test_table = Table.new(9)
			test_table.dealer.preflop
			fta = test_table.dealer.first_to_act
			test_table.dealer.action_driver
			test_table.dealer.action_driver.should match(/(Call|Fold|Raise|Check)/)
		end
	end
end