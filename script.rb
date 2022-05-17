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

class Round
    def initialize(initial_selection, num_rounds)
        @initial_selection = initial_selection
        @computer_score = 0
        @player_score = 0
        if @initial_selection == 1
            num_rounds.times do
                CodeBreaker.new
                CodeMaker.new
            end
        else
            num_rounds.times do
                @comp = CodeMaker.new
                @computer_score += @comp.computer_score
                @player = CodeBreaker.new

            end
        end      
    end
end

class CodeMaker
    attr_reader :computer_score

    def initialize
        
        @code = get_code
        puts @code
        @guesses_remaining = 12
        initial_display
    end

    def initial_display
        puts "\n\n\n\n\n\n\n\n\n\nYou are playing this round as the Code-Breaker.  You must attempt to guess the computer's code."
        sleep 2
        puts "\nThe following colors will be represented with the corresponding code:"
        sleep 2
        puts "\nRed: 1, Blue: 2, Green: 3, Yellow: 4, Orange: 5, Purple: 6"
        sleep 2
        puts "\nThe computer's code will be displayed as a 4-digit number, with each digit being a number between 1-6. Example: 6142"
        begin_attempts
    end

    def get_code
        code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
        code.uniq.length == 4 ? code : get_code
    end

    def begin_attempts
        while @guesses_remaining > 0  
            puts "\nEnter your guess:"
            guess = get_guess
            if guess == @code.join
                return round_won
            end
            display_progress(guess)
        end
        round_lost
    end

    def get_guess
        guess = gets.chomp
        if guess.gsub(/[1-6]{4}/, '').empty? 
            guess
        else
            invalid_guess
            get_guess
        end
    end

    def display_progress(guess)
        correct_position = guess.split('').select.with_index { |num, ind| num.to_i == @code[ind] }.length
        correct_color = guess.split('').uniq.count { |num| @code.include?(num.to_i)} - correct_position
        @guesses_remaining -= 1
        puts "\nYour guess: #{guess}     Colors in correct positions: #{correct_position}     Correct colors in incorrect positions: #{correct_color}     Guesses remaining: #{@guesses_remaining}"
    end

    def round_won
        @computer_score = (12 - @guesses_remaining) + 1
        puts "\n\n\n\n\n\n\n\n\n\nYou guessed the code!  It took you #{@computer_score} guesses, awarding the computer #{@computer_score} points!"
        
        
    end

    def round_lost
        puts "\n\n\n\n\n\n\n\n\n\nYou've run out of guesses.  The computer has been awarded 12 points!"
        @computer_score = 12
    end

    def invalid_guess
        puts "\nInvalid input.  Enter a 4 digit number, with each digit being a number between 1-6. Example: 6142"
    end
end

class CodeBreaker
    

    def initialize
        initial_display
        @code = get_code
    end

    def initial_display
        puts "\n\n\n\n\n\n\n\n\n\nYou are playing this round as the Code-Maker.  You must create a code which the computer will attempt to guess."
        sleep 2
        puts "\nThe following colors will be represented with the corresponding code:"
        sleep 2
        puts "\nRed: 1, Blue: 2, Green: 3, Yellow: 4, Orange: 5, Purple: 6"
        sleep 2
        puts "\nSelect a 4-digit sequence of numbers 1-6, which the computer will attempt to guess.  Repeating numbers are not allowed. Example: 6142"
    end

    def get_code

        code = gets.chomp
        if !code.gsub(/[1-6]{4}/, '').empty? || code.split('').uniq.length != 4 
            puts "Invalid input.  Enter a 4 digit number, with each digit being a number between 1-6. Repeating numbers are not allowed. Example: 6142"
            get_code
        else
            code
        end

    end

end
PlayGame.new