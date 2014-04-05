class Hand

	attr_reader :hand, :player

	def initialize(cards, player)
		@player = player.seat
		@hand = cards
	end
end