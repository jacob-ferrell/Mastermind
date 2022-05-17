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
