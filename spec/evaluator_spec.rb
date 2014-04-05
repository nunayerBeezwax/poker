require 'spec_helper'

describe Evaluator do
	describe '.make_best' do
		it 'receives a hand and returns the best hand type it contains' do
			test_hand = []
			test_hand << Card.new('D', 3)
			test_hand << Card.new('D', 2)
			test_hand << Card.new('D', 5)
			test_hand << Card.new('D', 4)
			test_hand << Card.new('D', 6)
			test_hand << Card.new('C', 5)
			test_hand << Card.new('S', 4)
			test_player = Player.new(1, 1000)
			hand = Hand.new(test_hand, test_player)
			Evaluator.make_best(hand).should eq 'straight_flush'
		end
	end

	describe '.flush' do
		it 'returns true if a given hand contains at least 5 of a suit' do
			test_hand = []
			7.times { |i| test_hand << Card.new('S', i + 1) }
			Evaluator.flush(test_hand).should eq true
			test_hand = []
			4.times { |i| test_hand << Card.new('S', i + 1) }
			3.times { |i| test_hand << Card.new('H', i + 1) }
			Evaluator.flush(test_hand).should eq false
		end
	end

	describe '.straight' do
		it 'returns true if a given hand contains any 5 rank in a row' do
			test_hand = []
			junk_hand = []
			junk_hand << Card.new('D', 4)
			junk_hand << Card.new('C', 5)
			junk_hand << Card.new('C', 11)
			junk_hand << Card.new('C', 8)
			junk_hand << Card.new('S', 2)
			junk_hand << Card.new('H', 3)
			junk_hand << Card.new('H', 8)
			7.times { |i| test_hand << Card.new('S', i + 1) }
			Evaluator.straight(test_hand).should eq true
			Evaluator.straight(junk_hand).should eq false
		end
	end

	describe '.pair' do
		it 'returns true if a given hand contains any two cards with same rank' do
			test_hand = []
			test_hand << Card.new('D', 2)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 8)
			test_hand << Card.new('C', 7)
			test_hand << Card.new('D', 10)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Evaluator.pair(test_hand).should eq false
		end
	end

	describe '.two_pair' do
		it 'returns true if a given hand contains any two pairs' do
			test_hand = []
			test_hand << Card.new('D', 2)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 3)
			test_hand << Card.new('C', 7)
			test_hand << Card.new('D', 7)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Evaluator.two_pair(test_hand).should eq true
		end
	end

	describe '.three_of_a_kind' do
		it 'returns true if a given hand has any three cards of same rank' do
			test_hand = []
			test_hand << Card.new('D', 2)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 3)
			test_hand << Card.new('C', 4)
			test_hand << Card.new('D', 7)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Evaluator.three_of_a_kind(test_hand).should eq false
		end
	end

	describe '.full_house' do
		it 'returns true if a given hand has any pair and three cards of same rank' do
			test_hand = []
			test_hand << Card.new('D', 2)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 3)
			test_hand << Card.new('C', 4)
			test_hand << Card.new('D', 4)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('C', 9)
			Evaluator.full_house(test_hand).should eq true
		end
	end

	describe '.four_of_a_kind' do
		it 'returns true if a given hand has any four cards of same rank' do
			test_hand = []
			test_hand << Card.new('D', 3)
			test_hand << Card.new('S', 3)
			test_hand << Card.new('H', 11)
			test_hand << Card.new('C', 3)
			test_hand << Card.new('D', 7)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Evaluator.four_of_a_kind(test_hand).should eq false
		end
	end

	describe '.straight_flush' do
		it 'returns true if a given hand has a straight all in one suit' do
			test_hand = []
			test_hand << Card.new('D', 3)
			test_hand << Card.new('D', 4)
			test_hand << Card.new('D', 9)
			test_hand << Card.new('D', 6)
			test_hand << Card.new('D', 7)
			test_hand << Card.new('S', 12)
			test_hand << Card.new('C', 9)
			Evaluator.straight_flush(test_hand).should eq false
		end
	end
end