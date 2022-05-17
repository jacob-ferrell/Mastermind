class Round
    attr_reader :player_score, :computer_score
    
    def initialize(initial_selection, num_rounds)
        @initial_selection = initial_selection
        @computer_score = 0
        @player_score = 0
        if @initial_selection == 1
            num_rounds.times do
                @player = CodeBreaker.new
                @player_score += @player.player_score
                @comp = CodeMaker.new
                @computer_score += @comp.computer_score
            end
        else
            num_rounds.times do
                @comp = CodeMaker.new
                @computer_score += @comp.computer_score
                @player = CodeBreaker.new
                @player_score += @player.player_score
            end
        end
        
        
    end
end
