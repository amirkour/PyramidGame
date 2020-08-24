require_relative 'BaseCommand.rb'

class QuitCommand < BaseCommand
    def initialize
        @pretty_console_description = "Quit"
    end

    def run_and_get_next_commands
        puts ""
        puts "QUITTING"
        puts ""
        return nil
    end
end