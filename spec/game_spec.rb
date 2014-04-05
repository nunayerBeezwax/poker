require 'spec_helper'

describe Game do
	describe '#initialize' do
	  it 'sets up a new game, with a table(with players) and a dealer(with a deck)' do	
	  	test_game = Game.new
	  	test_game.table.players.length.should eq 9
	  	test_game.dealer.deck.cards.length.should eq 52
	  	test_game.table.pot.should eq 0
	  	test_game.table.board.should eq []
			test_game.table.button.should be_between(1, 9)
	  end	
	end

	describe '#hand' do
		it 'moves the button, empties the pot, clears the board' do
			test_game = Game.new
			test_game.table.button.should be_between(1, 9)
			button_position1 = test_game.table.button
			test_game.hand
			test_game.table.pot.should eq 0
			test_game.table.board.should eq []
			test_game.table.button.should eq button_position1 + 1
		end
	end	
end