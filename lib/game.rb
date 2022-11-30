class Game

    require_relative 'words'
    require_relative 'display'
    include Display

    def initialize
        @words = Words.new
        @turn = 0
        @game_over = false
        @head = ' '
        @body = ' '
        @left_arm = ' '
        @right_arm = ' '
        @left_leg = ' '
        @right_leg = ' '
    end

    def check_guessed_letter
        @words.chosen_word_array.each_with_index do |letter, index|
            if @words.guessed_letter == letter
                @words.guessed_word_array[index] = @guessed_letter
            end
        end
        if @words.chosen_word_array.include?(@guessed_letter) == false
            @turn +=1
            add_to_gallows
        end
        display_used_letters
    end

    def check_if_winner
        if @words.chosen_word_array.eql?(@words.guessed_word_array) && @words.incorrect_letters_used <= 5
            display_win
            @game_over = true
        elsif @words.incorrect_letters_used > 5
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

    def set_up_game
        words.choose_word

    end

end
