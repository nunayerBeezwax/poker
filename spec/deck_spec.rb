require 'spec_helper'

describe 'Deck' do

	describe '#initialize' do
		it 'creates a standard deck of playing cards' do
			test_deck = Deck.new
			test_deck.should be_an_instance_of Deck
			test_deck.cards.count.should eq 52
			test_deck.cards[0].should be_an_instance_of Card
		end
	end

	describe '#give_card' do
		it 'removes the top card from the deck and passes it to the dealer' do
			test_deck = Deck.new
			test_deck.give_card.should be_an_instance_of Card
			test_deck.cards.count.should eq 51
			test_deck.give_card
			test_deck.give_card
			test_deck.give_card
			test_deck.cards.count.should eq 48
		end
	end
end
