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
	dealer = game.table.dealer
	players = table.players
	button = table.button
	# Looking at things, user functionality for later
	# user = game.table.sample
	puts "Press 'd' to Shuffle up and Deal"
	if gets.chomp =='d'
		dealer.preflop
	end
	puts "Button is on seat #{button}",
			 "Blinds are #{table.sb} #{table.bb}",
			 "The pot is #{table.pot}",
			 "----------------"
	fta = dealer.first_to_act
	p = table.players.find{ |p| p.seat == fta }
	table.active_players.count.times do 
		puts "Action is on #{dealer.action_tracker}",
				 "Who has #{p.chips} chips and",
				 "#{p.hole_cards[1].rank} of #{p.hole_cards[1].suit}",
			 	 "#{p.hole_cards[0].rank} of #{p.hole_cards[0].suit}",
				 "It's #{table.current_bet} to call",
				 "Player #{p.seat} #{dealer.action_driver}s",
				 "And so has #{p.chips} left.",
				 "-----------------"
		print "Press Enter to move to the next player:"
		gets.chomp
		p = table.players.find { |p| p.seat == dealer.action_tracker }
	end

	puts "The players still in the hand are: "
	table.active_players.each do |player|
	 	puts "#{player.seat}"
	end
	puts "The pot is up to #{table.pot}"

	puts "Press 'F' to move to the flop:"
	if gets.chomp == 'f'
		dealer.flop
	end

	puts "There are #{table.active_players.count} players still in the hand"
	puts "The pot is now #{game.table.pot}"
	puts "\nHere is the flop:",
			 "--------------------",
			 "#{game.table.board[0].rank} of #{game.table.board[0].suit}",
			 "#{game.table.board[1].rank} of #{game.table.board[1].suit}",
			 "#{game.table.board[2].rank} of #{game.table.board[2].suit}",
			 "-------"

	active_players.each do |p|
		puts "#Player #{p.seat} will #{p.decision(p.combine(table.board), 100)}",
				 "-----------------"
	end

	table.action 

	puts "Now the players still in the hand are: "
	table.active_players.each do |player|
	 	puts "#{player.seat}"
	end

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
	if gets.chomp == 'r'
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

	game.table.active_players.each do |player|
		puts "Player #{player.seat} got a #{Evaluator.make_best(player.combine(table.board))}"
	end
	main_menu
end

main_menu