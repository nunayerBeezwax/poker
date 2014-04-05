class Evaluator
	
	def Evaluator.make_best(hand)
		hand = hand.hand
		score = 0
		best_hand = { 1 => 'high_card', 2 => 'pair', 3 => 'two_pair', 4 => 'three_of_a_kind',
					  5 => 'straight', 6 => 'flush', 7 => 'full_house', 8 => 'four_of_a_kind',
					  9 => 'straight_flush' }

		best_hand.each do |key, value|
			x = eval("self.#{value}(hand)")
			if x == true
				score = key
			end
		end
		best_hand[score]
	end

	def self.high_card(hand)
		hand.sort_by { |card| card.rank }
		true
	end

	def self.pair(hand)
		hand.each do |card|
			if hand.any? { |c| card.rank == c.rank && card != c }
				return true
			end
		end
		false
	end

	def self.two_pair(hand)
		pairs = 0

		13.times do |i|
			if hand.count { |card| card.rank == i + 1 } == 2
				pairs += 1
			end
		end
	
		pairs >= 2
	end

	def self.three_of_a_kind(hand)
		13.times do |i|
			if hand.count { |card| card.rank == i + 1 } == 3
				return true
			end
		end
		false
	end

	def self.straight(hand)
		temp_hand = hand.clone
		temp_hand.sort_by! { |card| card.rank }
		temp_hand.uniq! { |card| card.rank }
		if temp_hand.length == 5
			if (temp_hand[0].rank - temp_hand[4].rank).abs == 4
				return true
			end
		elsif temp_hand.length == 6
			if (temp_hand[1].rank - temp_hand[5].rank).abs == 4 ||
				 (temp_hand[0].rank - temp_hand[4].rank).abs == 4
				return true
			end
		elsif temp_hand.length == 7
			if (temp_hand[0].rank - temp_hand[4].rank).abs == 4 ||
				 (temp_hand[1].rank - temp_hand[5].rank).abs == 4 ||
				 (temp_hand[2].rank - temp_hand[6].rank).abs == 4
				return true
			end
		end
		false
	end

	def self.flush(hand)
		suits = %w{ H S C D }

		suits.each do |s|
			return true if hand.count { |card| card.suit == s } >= 5
		end
		false
	end

	def self.full_house(hand)
		trips = 0
		pairs = 0
		
		13.times do |i|
			if hand.count { |card| card.rank == i + 1 } == 3
				trips += 1
			end
			if hand.count { |card| card.rank == i + 1 } == 2
				pairs += 1
			end
		end
		
		trips >= 1 && pairs >= 1
	end

	def self.four_of_a_kind(hand)
        13.times do |i|
        	if hand.count { |card| card.rank == i + 1 } == 4
        		return true
        	end
        end
        false		
	end

	def self.straight_flush(hand)
		straight = false
		temp_hand = hand.clone
		temp_hand.sort_by! { |card| card.rank }
		temp_hand.uniq! { |card| card.rank }
		if temp_hand.length == 5
			if (temp_hand[0].rank - temp_hand[4].rank).abs == 4
				straight = true
			end
		elsif temp_hand.length == 6
			if (temp_hand[1].rank - temp_hand[5].rank).abs == 4 ||
				 (temp_hand[0].rank - temp_hand[4].rank).abs == 4
				straight = true
			end
		elsif temp_hand.length == 7
			if (temp_hand[0].rank - temp_hand[4].rank).abs == 4 ||
				 (temp_hand[1].rank - temp_hand[5].rank).abs == 4 ||
				 (temp_hand[2].rank - temp_hand[6].rank).abs == 4
				straight = true
			end
		end
		if straight == true 
			if temp_hand.count { |card| card.suit } == 5
				return true
			end
		end
	false
	end
end