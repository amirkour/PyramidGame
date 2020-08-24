require_relative 'BaseCommand.rb'
require_relative 'GameMoveCommand.rb'
# require_relative '../PyramidGame.rb'

class NewGameCommand < BaseCommand
    def initialize
        @pretty_console_description = "Play a new game of Pyramid"
    end

    def run_and_get_next_commands
        rings = 0
        stacks = 0

        while true
            puts ""
            puts "Enter number of rings for this game"
            print "> "
            input = gets.chomp.downcase.to_i
            puts ""

            if input <= 0 then
                puts "Please enter a positive integer"
            else
                rings = input
                break
            end
        end

        while true
            puts ""
            print "Enter number of stacks for this game: "
            print "> "
            input = gets.chomp.downcase.to_i
            puts ""

            if input <= 0 then
                puts "Please enter a positive integer"
            else
                stacks = input
                break
            end
        end

        game = PyramidGame.new(:num_stacks => stacks, :num_rings => rings)
        return [QuitCommand.new, GameMoveCommand.new(:game => game)]
    end
end