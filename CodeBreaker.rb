class CodeBreaker
    attr_reader :player_score

    def initialize
        initial_display
        @code = get_code
        @s = (1111..6666).to_a.reject { |num| num.to_s =~ /[7890]/ || num.digits.uniq.length < 4}
        @guesses_remaining = 12
        begin_computer_attempts
    end

    def initial_display
        puts "\n\n\n\n\n\n\n\n\n\nYou are playing this round as the Code-Maker.  You must create a code which the computer will attempt to guess."
        sleep 1
        puts "\nThe following colors will be represented with the corresponding code:"
        sleep 1
        puts "\nRed: 1, Blue: 2, Green: 3, Yellow: 4, Orange: 5, Purple: 6"
        sleep 1
        puts "\nSelect a 4-digit sequence of numbers 1-6, which the computer will attempt to guess.  Repeating numbers are not allowed. Example: 6142"
    end

    def get_code
        code = gets.chomp
        if !code.gsub(/[1-6]{4}/, '').empty? || code.split('').uniq.length != 4 
            puts "Invalid input.  Enter a 4 digit number, with each digit being a number between 1-6. Repeating numbers are not allowed. Example: 6142"
            get_code
        else
            code.to_i.digits
        end

    end

    def begin_computer_attempts
        make_guess(@s[rand(0..(@s.length - 1))])
        
        while @guesses_remaining > 0
            if @next_guess.digits == @code
                return round_won
            end
            make_guess(@next_guess)
        end
        return round_lost
    end

    def make_guess(guess)
        feedback = get_feedback(guess)
        @guesses_remaining -= 1
        sleep 1
        puts "\nComputer's guess: #{guess}     Colors in correct positions: #{feedback[0]}     Correct colors in incorrect positions: #{feedback[1]}     Guesses remaining: #{@guesses_remaining}"
        @s = @s.reject { |num| get_feedback(num, guess.digits) != feedback }
                
        @next_guess = @s[rand(0..(@s.length - 1))]

    end

    def get_feedback(guess, code=@code)
        correct_position = guess.digits.select.with_index { |num, ind| num == code[ind] }.length
        correct_color = guess.digits.uniq.count { |num| code.to_s.include?(num.to_s)} - correct_position
        [correct_position, correct_color]
    end

    def round_won
        @player_score = (12 - @guesses_remaining) + 1
        puts "\n\n\n\nThe computer guessed the code in #{@player_score} guesses.  You have been awarded #{@player_score} points!"
    end

    def round_lost
        puts "The computer was unable to guess the code!  You have been awarded 12 points!"
    end

end