class Deck
	
	attr_reader :cards

	def initialize
		@cards = []
		rank = %w{ 2 3 4 5 6 7 8 9 10 11 12 13 14 }
		suit = %w{ C S H D }
		suit.each do |suit| 
			rank.each do |rank| 
				@cards << Card.new(suit, rank)
			end
		end
		@cards
	end

	def shuffle
		@cards.shuffle!
	end

	def give_card
		@cards.shift
	end
end