class Player
	attr_reader :chips, :hole_cards, :name, :seat, :hand, :raise, :brain, :table

	def initialize(seat, chips, table)
		@hole_cards = []
		@chips = chips
		### Maybe have a 'position' attribute?
		@seat = seat
		@table = table
		@hand = []
		@brain = Brain.new
	end

	def get_card(card)
		@hole_cards << card
	end

	def combine(board)
		self.hole_cards.each { |card| @hand << card }
		board.each { |card| @hand << card }
		@hand.sort_by!{ |card| card.rank }
	end

	def fold
		@hole_cards = []
		@hand = []
		'Fold'
	end

	def call(amount)
		@chips -= amount
		@table.bet(amount)
		'Call'
	end

	def raise(amount)
		@chips -= amount
		@raise = amount 
		@table.bet(amount)
		'Raise'
	end

	def ante(amount)
		self.call(amount)
	end

	def decision(hand, bet)
		if @hand.count == 2
			case self.brain.preflop(@hand, bet)
			when 'Call'
				if self.seat == table.button+2 && @table.current_bet == @table.bb
					'Check'
				else	
					self.call(@table.current_bet)
				end
			when 'Raise'
				self.raise(@table.current_bet*3)
			when 'Fold' 
				if self.seat == table.button+2 && @table.current_bet == @table.bb
					'Check'
				else
					self.fold
				end
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