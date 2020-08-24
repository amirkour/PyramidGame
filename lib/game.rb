require_relative 'PyramidGame.rb'
require_relative './RunCommands/NewGameCommand.rb'
require_relative './RunCommands/QuitCommand.rb'

commands = [QuitCommand.new, NewGameCommand.new]

puts ""
puts "Pyramid Game!?"
puts ""

while !commands.nil? && commands.size > 0

    next_command = nil
    puts ""
    puts "Your current options are:"
    while true
        commands.each_index do |i|
            puts "[#{i}] #{commands[i].pretty_console_description}"
        end

        puts "Make a selection"
        print "> "
        input = gets.chomp.downcase.to_i
        if input < 0 || input >= commands.size then
            puts "Please enter a valid integer/selection from the list"
            puts ""
            next
        else
            next_command = commands[input]
            break
        end
    end

    commands = next_command.run_and_get_next_commands()
end


