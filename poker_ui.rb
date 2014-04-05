require './lib/dealer'
require './lib/evaluator'
require './lib/game'
require './lib/deck'
require './lib/player'
require './lib/table'
require './lib/card'
require './lib/brain'
require 'pry'

def main_menu
	# puts "Poker: ", 
	# 		 "Press 'N' to start a New Game"
	# choice = gets.chomp.downcase
	# case choice
	# when 'n'
		new_game
	# when 'x'
	# 	exit
	# else 
	# 	puts "Invalid entry, please try again."
	# 	main_menu
	# end
end

def new_game
	game = Game.new
	table = game.table
	dealer = game.dealer
	players = table.players
	user = game.table.players[0]
	##this 0 can be a .sample to be randomized, just hard coded it to mess with other things
	puts "Press 'D' to deal"
	choice = gets.chomp.downcase
		case choice
		when 'd'
			dealer.preflop
		end
	puts "\nYour hole cards are:",
			 "----------------------"
	puts "#{user.hole_cards[0].rank} of #{user.hole_cards[0].suit}",
				"#{user.hole_cards[1].rank} of #{user.hole_cards[1].suit}",
			 "-------", 
			 "You have #{user.chips} chips",
			 "The pot is #{table.pot}"
	players[1..8].each do |p|
		puts "#Player #{p.seat} has",
				 "#{p.hole_cards[0].rank} of #{p.hole_cards[0].suit}",
				 "#{p.hole_cards[1].rank} of #{p.hole_cards[1].suit}",
				 "and so will #{p.decision(p.combine(table.board), 100)}"
	end
	table.action
	puts "Press 'C' to call"
	call = gets.chomp.downcase
		if call == 'c'
			##need to turn this into a variable which references current bet or just bb
			user.call(100)
		else
			user.fold
		end
	puts "Which means the players still in the hand are: "
	table.active_players.each do |player|
	 	puts "#{player.seat}"
	end
	puts "Press 'F' to see the flop:"
	choice = gets.chomp.downcase
		if choice == 'f'
			dealer.flop
		end
	puts "There are #{table.active_players.count} players still in the hand"
	puts "The pot is now #{game.table.pot}"
	puts "Your chip stack is #{user.chips}"
	puts "\nHere is the flop:",
			 "--------------------",
			 "#{game.table.board[0].rank} of #{game.table.board[0].suit}",
			 "#{game.table.board[1].rank} of #{game.table.board[1].suit}",
			 "#{game.table.board[2].rank} of #{game.table.board[2].suit}",
			 "-------"
	puts "Press 'T' to see the turn:"
	choice = gets.chomp.downcase
		if choice == 't'
			game.dealer.turn
		end
	puts "\nHere is the turn:",
			 "--------------------",
			 "#{game.table.board[0].rank} of #{game.table.board[0].suit}",
			 "#{game.table.board[1].rank} of #{game.table.board[1].suit}",
			 "#{game.table.board[2].rank} of #{game.table.board[2].suit}",
			 "#{game.table.board[3].rank} of #{game.table.board[3].suit}",
			 "-------"
	puts "Press 'R' to see the river:"
	choice = gets.chomp.downcase
		if choice == 'r'
			game.dealer.river
		end
	puts "\nHere is the river:",
			 "--------------------",
			 "#{game.table.board[0].rank} of #{game.table.board[0].suit}",
			 "#{game.table.board[1].rank} of #{game.table.board[1].suit}",
			 "#{game.table.board[2].rank} of #{game.table.board[2].suit}",
			 "#{game.table.board[3].rank} of #{game.table.board[3].suit}",
			 "#{game.table.board[4].rank} of #{game.table.board[4].suit}",
			 "-------"
	user_hand = user.combine(game.table.board)
	puts "You got a #{Evaluator.make_best(user_hand)}"
	game.table.active_players.each do |player|
		puts "Player #{player.seat} got a #{Evaluator.make_best(player.combine(table.board))}"
	end
	main_menu
end

main_menu