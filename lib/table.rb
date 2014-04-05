class Table

	attr_reader :players, :board, :hands, :pot, :button, :active_players, :sb, :bb, :action

	def initialize(num_of_players)
		@players = []
		num_of_players.times { @players << Player.new(@players.length+1, 1000) }
		@board = []
		@pot = 0
		@button = rand(0..@players.length - 1)
		@hands = []
	end

	def community_cards(card)
		@board << card
	end

	#rotate is pretty cool, think this is the right way, though I don't yet know
	#how the each loop will interact with all the intermediary decisions/actions
	#the condition means to assure that only non-folded players get to make decisions
	#SAME CONDITION WILL NEED TO BE ADDED IN SHOWDOWN, probably other places too
	def action
		@players.rotate(@button + 1).each do |player|
			if player.hole_cards.count == 2
				hand = player.combine(@board)
				if player.decision(hand, @pot) == 'Call'
					@pot += 100
				elsif player.decision(hand, @pot) == 'Raise'
					self.bet(300)
				end
			end
		end
	end

	def bet(raise)
		@pot += raise
	end

	def showdown
		### Needs significant retooling
		# @hands = []
		# winner = []
		# @players.each do |player|
		# 	@hands << player.combine(@board)
		# end
		# @hands.each do |hand|
		# 	winner << "Player #{hand.player.seat}: #{Evaluator.make_best(hand)}"
		# end
		# @players.each do |player|
		# 	puts "---------"
		# 	player.hole_cards.each do |card|
		# 		puts "#{player.seat}: #{card.rank} #{card.suit}"
		# 	end
		# end
		# @board.each do |card|
		# 	puts "#{card.rank} #{card.suit}"
		# end
		# return winner
	end

	def active_players
		@players.select do |player| 
			player.hole_cards.count == 2
		end
	end

	def clear_board
		@board = []
	end

	def empty_pot
		@pot = 0
	end

	def move_button
		@button += 1
		if @button == @players.count
			@button = 0
		end
	end

## need to find a way to do a clock or hand counter to increment blinds
## otherwise, pretty confident they are functioning properly
## can do with refactoring as to the index out of range issue
	def blinds_table
		@blinds_table = { 1 => 50, 2 => 100, 3 => 200, 4 => 400 }
	end

	def blinds(level)
		self.small_blind(level)
		self.big_blind(level)
	end

	def small_blind(level)
		@sb = (self.blinds_table[level]) / 2
		@players[((@button + 1) <= 8) ? (@button + 1) : 0].ante(@sb)
		@pot += @sb
	end

	def big_blind(level)
		@bb = (self.blinds_table[level])
		if @button + 2 == 9
			@players[0].ante(@bb)
		elsif @button + 2 == 10
			@players[1].ante(@bb)
		else
			@players[@button + 2].ante(@bb)
		end
		@pot += @bb
	end
end