require 'spec_helper'

describe 'Card' do
	describe '#initialize' do
		it 'creates a Card object' do
			test_card = Card.new("H", 5)
			test_card.should be_an_instance_of Card
			test_card.suit.should eq "H"
			test_card.rank.should eq 5
		end
	end
end