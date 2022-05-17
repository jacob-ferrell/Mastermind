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