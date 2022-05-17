require_relative "Round.rb"
require_relative "CodeMaker.rb"
require_relative "CodeBreaker.rb"


class PlayGame
    attr_accessor :player_score, :computer_score

    def initialize
        @player_score = 0
        @computer_score = 0
        new_game_display
        @initial_selection = get_initial_selection
        Round.new(@initial_selection, @num_rounds)
    end

    def new_game_display
        puts "\n\n\n\n\n\n\n\n\n\nA new game of Mastermind has begun!"
        get_num_rounds
        
    end

    def get_num_rounds
        puts "\nA round consists of the player playing once as Code-Breaker, and once as Code-Maker, not necessarily in that order."
        puts "\nEnter a number signifying how many rounds you wish to play:"
        @num_rounds = gets.chomp.to_i
    end

    def get_initial_selection
        puts "\nWill you begin as Code-Maker(Enter: 1), or Code-Breaker(Enter: 2)?"
        selection = gets.chomp.to_i
        if valid_input?(selection)
             selection
        else
            invalid_input
            get_initial_selection
        end
    end

    def valid_input?(selection)
        [1, 2].include?(selection)
    end

    def invalid_input
        puts "Invalid choice.  Enter 1 to begin as Code-Maker, or 2 to begin as Code-Breaker"
    end
end

PlayGame.new