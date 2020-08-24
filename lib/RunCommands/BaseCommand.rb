class BaseCommand
    attr_reader :pretty_console_description

    def run_and_get_next_commands
        raise "Your class has to implement this, and return a list of BaseCommand objects (or nil to end the game)"
    end
end