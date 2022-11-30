class Game

    require_relative 'words'
    require_relative 'display'
    include Display

    def initialize
        @hangman = Words.new
        @game_over = false
        @turn = 0
        @head = ' '
        @body = ' '
        @left_arm = ' '
        @right_arm = ' '
        @left_leg = ' '
        @right_leg = ' '
    end

    def check_if_winner
        if @hangman.chosen_word_array.eql?(@hangman.guessed_word_array) && @turn <= 5
            display_win
            @game_over = true
        elsif @turn > 5
            @game_over = true
        end
    end

    def add_to_gallows
        case @turn
        when 1
            @head = 'o'
        when 2
            @body = '|'
        when 3
            @left_arm = '/'
        when 4
            @right_arm = '\\'
        when 5
            @left_leg = '/'
        when 6
            @right_leg = '\\'
    end

end