class Game

    require_relative 'words'
    require_relative 'display'
    include Display

    def initialize
        @words = Words.new
        @incorrect_guesses = 0
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
                @words.guessed_word_array[index] = @words.guessed_letter
            end
        end
        if @words.chosen_word_array.include?(@words.guessed_letter) == false
            add_to_gallows
            @incorrect_guesses += 1
        end
        display_used_letters
    end

    def check_if_winner_loser
        if @words.chosen_word_array.eql?(@words.guessed_word_array) && @incorrect_guesses < 5
            display_win
            @game_over = true
        elsif @incorrect_guesses == 6
            add_to_gallows
            display_gallows
            display_loss
            display_the_word
            @game_over = true
        end
    end

    def add_to_gallows
        case @incorrect_guesses
        when 0
            @head = 'O'
        when 1
            @body = '|'
        when 2
            @left_arm = '/'
        when 3
            @right_arm = '\\'
        when 4
            @left_leg = '/'
        when 5
            @right_leg = '\\'
        end
    end

    def gameplay_loop
        display_instructions
        @words.choose_word
        display_guessed_array
        while @game_over == false
            @words.guess_letter
            check_guessed_letter
            check_if_winner_loser
            if @incorrect_guesses < 6
                display_gallows
                display_guessed_array
            end
        end
        play_again?
    end

    def play_again?
        display_play_again
        response = gets.chomp.upcase
        if response == 'Y'
            reset
            gameplay_loop
        elsif response == 'N'
            display_thanks
        else
            display_play_again_invalid
            play_again?
        end
    end

    def reset
        @words = Words.new
        @incorrect_guesses = 0
        @game_over = false
        @head = ' '
        @body = ' '
        @left_arm = ' '
        @right_arm = ' '
        @left_leg = ' '
        @right_leg = ' '
    end




end
