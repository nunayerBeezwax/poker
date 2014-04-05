require 'rspec'
require 'deck'
require 'card'
require 'player'
require 'dealer'
require 'game'
require 'hand'
require 'table'
require 'brain'
require 'evaluator'
require 'pry'

describe Table do
	before :each do 
		Table.pot = 0
	end
end