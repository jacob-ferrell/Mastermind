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
