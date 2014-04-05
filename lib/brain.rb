class Brain

	attr_reader :situation, :hand_types, :outs, :odds, :preflop

	def preflop(hand, bet)
		if hand.hand[0].rank == hand.hand[1].rank
			'Raise'
		elsif hand.hand[0].suit == hand.hand[1].suit && (hand.hand[0].rank == 14 || hand.hand[1].rank == 14)
			'Call'
		elsif hand.hand[0].rank > 11 && hand.hand[1].rank > 11
			'Call'
		elsif (hand.hand[0].rank - hand.hand[1].rank).abs == 1 && hand.hand[0].suit == hand.hand[1].suit
			'Call'
		elsif (hand.hand[0].rank == 14 || hand.hand[1].rank == 14) && hand.hand[0].suit == hand.hand[1].suit
			'Call'
		else 
			'Fold'
		end
	end


	def draw(hand, deal)
		@hand_types = { 1 => 'high_card', 2 => 'pair', 3 => 'two_pair', 4 => 'trips',
		  5 => 'straight', 6 => 'flush', 7 => 'boat', 8 => 'quads', 9 => 'straight_flush' }
		remaining = cards_left(deal)
		@outs = {}
		@odds = {}
		@hand_types.each do |key, value|
			@outs["#{value}"] = outs_calculator(hand, value)
		end
		# the results of the following line are the odds of hitting a flush by the river
		@odds['flush'] = flush_draw(hand, @outs['flush'])

		### Other things that this method might want:
		# percent of what card comes out next
		# the rest of the method calls(passed outs) to get all percentages
	end

	def improvement(hand)
		if Evaluator(hand << card) > Evaluator(hand)
			true
		end
	end

	def flush_draw(hand, outs)
		deck = (52 - hand.hand.hand.length).to_f
		(@outs['flush'] / deck) + (((@outs['flush'] / (deck - 1)) * (1 - @outs['flush'] / deck)))
	end

	def outs_calculator(current_hand, desired_hand)
		case desired_hand
		when 'flush'
			13 - count_suit(current_hand)
		when 'straight'
			#something...
		end
	end

	def cards_left(deal)
		case deal
		when 'preflop'
			5
		when 'flop'
			2
		when 'turn'
			1
		else 
			nil
		end
	end

	def count_suit(hand)
		suit_count = 0
		suits = %w{ H S C D }
		suits.each do |s|
			count = hand.hand.hand.count { |card| card.suit == s }
			if count > suit_count 
				suit_count = count
			end
		end
		suit_count
	end

###################################################
#  Big Future Projects/Considerations             #
###################################################
	# def read
	# 	# accesses database info on player in question for a type
	# end

	# def situation
	# 	chips = self.chips
	# 	pot = pot.chips
	# 	position = self.position
	# 	hand = hand.quality(including current and draw percent)
	# 	action = incoming(raise(re-raise?))
	# 	players = players in hand
	# 	pot_odds 
	# 	read_of_players_in_hand
	# end

	# def pot_odds
	# 	#computes 
	# end

end