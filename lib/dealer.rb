class Dealer

	attr_reader :deck, :table

	def initialize(table)
		@deck = Deck.new
		@deck.shuffle
		@table = table
	end

	def deal
		@deck.shuffle
		@table.blinds(1)
		self.preflop
		@table.action
		self.flop
		@table.action
		self.turn
		@table.action
		self.river
		@table.action
	end

	def preflop
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
end