require_relative 'BaseCommand.rb'
# require_relative 'PyramidGame.rb'

class GameMoveCommand < BaseCommand
    attr_reader :game

    def initialize(options = {})
        options = options.nil? || !options.kind_of?(Hash) ? {} : options
        @game = options[:game] || nil
        @pretty_console_description = "Make a move in the current PyramidGame"
    end

    def run_and_get_next_commands
        if @game.nil? || !@game.kind_of?(PyramidGame) then
            puts ""
            puts "The GameMoveCommand requires an instance of PyramidGame to work ... exiting"
            puts ""
            return nil
        end

        puts "Current game: #{@game.stacks.size} stacks, #{@game.num_rings} rings, #{@game.num_moves} moves so far"

        x = nil
        y = nil
        input = nil
        while !@game.game_over?
            puts "Make a move, or type 'q' to stop playing!"
            @game.stacks.each_index do |i|
                stack = @game.stacks[i]
                print "[#{i}] - [ "
                stack.reverse_each{|s| print "#{s} "}
                puts "]"
            end
            
            print "Stack to take a ring from: "
            x = gets.chomp.downcase
            break unless !x.eql?('q')
            x = x.to_i

            print "Stack to move to: "
            y = gets.chomp.downcase
            break unless !y.eql?('q')
            y = y.to_i

            puts "Moving a ring from stack #{x} to #{y} ..."
            puts "Invalid move, try again!" unless @game.make_move(x,y)
            puts ""
        end

        commands = nil
        if @game.game_over? then
            puts "Game over, you win!"
            puts "#{@game.stacks}"
        else
            commands = [QuitCommand.new, self]
            puts "Quitting, for now"
        end

        commands
    end
end