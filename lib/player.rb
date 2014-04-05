class Player
	attr_reader :chips, :hole_cards, :name, :seat, :hand, :raise, :brain

	def initialize(seat, chips)
		@hole_cards = []
		@chips = chips
		@seat = seat
		@hand = []
		@brain = Brain.new
	end

	def get_card(card)
		@hole_cards << card
	end

	def combine(board)
		self.hole_cards.each { |card| @hand << card }
		board.each { |card| @hand << card }
		Hand.new(@hand, self)
		##Let's make it so that when a player makes a hand, they
		##sort it right there, I guess by rank
	end

	def fold
		@hole_cards = []
		@hand = []
	end

	def call(amount)
		@chips -= amount
	end

	def raise(amount)
		@chips -= amount
		@raise = amount 
	end

	def ante(amount)
		@chips -= amount
	end

	def decision(hand, bet)
		if hand.hand.length == 2
			case self.brain.preflop(hand, bet)
			when 'Call'	
				self.call(bet)
				return 'Call'
			when 'Raise'
				self.raise(bet*3)
				return 'Raise'
			when 'Fold' 
				self.fold
				return 'Fold'
			end
		# elsif hand.hand.length == 5
			# postflop_decision(hand, bet)
		# elsif hand.hand.length == 6
			# turn_decision(hand, bet)
		# else
			# river_decision(hand, bet)
		end
	end
end