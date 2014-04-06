class Dealer

	attr_reader :deck, :table, :action_tracker

	def initialize(table)
		@deck = Deck.new
		@deck.shuffle
		@table = table
		@action_tracker = 0
	end

	def first_to_act
		if @table.board == []
			@action_tracker += table.button + 3
			if @action_tracker == 11
				@action_tracker = 2
			elsif @action_tracker == 10
				@action_tracker = 1
			else
				@action_tracker
			end
		else
			@action_tracker += table.button + 2
		end
	end

	def action_patch
		if @action_tracker == 10
			@action_tracker = 1
		elsif @action_tracker == 11
			@action_tracker = 2
		else
			@action_tracker
		end
	end

	def action_driver
		self.action_patch
		player = @table.players.find{ |player| player.seat == @action_tracker } 
		@action_tracker += 1
		self.action_patch
		@table.action(player)
	end

	def preflop
		@action_tracker = 0
		@table.blinds(1)
		i = 0
		until @table.players[8].hole_cards.length == 2
			@table.players.each do |player|
				player.get_card(@deck.give_card)
				i += 1
			end
		end
	end

	def flop
		3.times do 
			card = @deck.give_card
			@table.community_cards(card) 
		end
	end

	def turn
		card = @deck.give_card
		@table.community_cards(card)
	end

	def river
		card = @deck.give_card
		@table.community_cards(card)
	end

	def self.clear
		@deck = []
	end

	def new_hand
		@table.clear_board
		@table.empty_pot
		@table.move_button
	end
end