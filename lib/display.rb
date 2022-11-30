module Display

    def display_instructions
        puts <<~HEREDOC
        Welcome to hangman. This is a simple game where a word is chosen randomly.
        You must guess the word by entering letters when prompted.
        You have 6 turns until the hanged man is fully drawn.
        Once the hanged man is fully draw, you lose.
        HEREDOC
    end

    def request_player_guess
        puts 'Please enter a letter: '
    end

    def display_used_letters
        puts "You have used these letters: #{@used_letters.join(' ')}"
    end

    def display_guessed_array
        puts @guessed_word_array.join(' ')
    end

    def display_invalid_guess
        puts 'Invalid entry. Your entry is either already used or not a letter. Please retry.'
    end

    def display_gallows
        puts <<~HEREDOC
        +---+
        |   |
        #{@head}   |
        #{@left_arm}#{@body}#{@right_arm} |
        #{@left_leg}#{@right_leg}  |
            |
      ============
      HEREDOC
    end

    def display_win
        puts "Congratulations! You have correctly guessed the word."
    end

    def display_loss
        puts "Sorry! You have not guessed the word in"
    end
end