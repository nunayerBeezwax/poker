class Game
	attr_reader :table, :dealer

	def initialize
		@table = Table.new(9)
		@dealer = Dealer.new(@table)
	end

	def hand
		self.table.clear_board
		self.table.empty_pot
		self.table.move_button
	end

end