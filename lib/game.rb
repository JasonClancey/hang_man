class Game

    require_relative 'words'
    require_relative 'display'
    require 'json'
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
        @dirname = 'saved_game_dir'
        @save_file = 'saved_game_dir/saved_game.json'
        @junk = 1
    end

    def guess_letter
        active = true
        display_request_guess_or_save
        @words.guessed_letter = gets.chomp.upcase
            while active
                if /[A-Z]/ =~ @words.guessed_letter && @words.used_letters.include?(@words.guessed_letter) == false && @words.guessed_letter.length == 1
                    active = false
                elsif @words.guessed_letter == 'SAVE'
                    save_game
                    exit
                else
                    display_invalid_guess
                    @words.guessed_letter = gets.chomp.upcase
                end
            end
        @words.used_letters.push(@words.guessed_letter)
        puts @words.guessed_letter
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
        load_game
        display_gallows
        display_guessed_array
        while @game_over == false
            guess_letter
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

    def to_json
        JSON.dump({
            used_letters: @words.used_letters,
            guessed_word_array: @words.guessed_word_array,
            chosen_word_array: @words.chosen_word_array,
            incorrect_guesses: @incorrect_guesses,
            head: @head,
            body: @body,
            left_arm: @left_arm,
            right_arm: @right_arm,
            right_leg: @right_leg,
            left_leg: @left_leg
        })
    end

    def from_json(save_file)
        variables = JSON.parse(File.read(save_file))
        @head = variables['head'],
        @body = variables['body'],
        @left_arm = variables['left_arm'],
        @right_arm = variables['right_arm'],
        @left_leg = variables['left_leg'],
        @right_leg = variables['right_leg'],
        @incorrect_guesses = variables['incorrect_guesses']
        @words = Words.new(
            variables['used_letters'],
            variables['guessed_word_array'],
            variables['chosen_word_array']
        )
    end

    def save_game
        Dir.mkdir(@dirname) unless Dir.exist?(@dirname)
        File.open(@save_file, 'w') do |file|
            file.puts(to_json)
        end
    end

    def load_game
        return unless File.exist?(@save_file)
        display_load_game?
        response = gets.chomp.upcase
        case response
        when 'Y'
            File.open(@save_file, 'r') do |file|
                from_json(@save_file)
            end
            puts "Save game loaded!"
            display_used_letters
        else 
            puts "No game loaded!"
            return
            File.delete(save_file)
        end
    end

end
