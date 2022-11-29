module Display

    head = ''
    body = ''
    left_arm = ''
    right_arm = ''
    left_leg = ''
    right_leg = ''

    def request_player_guess
        puts "Please enter a letter: "
    end

    def display_used_letters
        puts "You have used these letters #{@used_letters.join(' ')}"
    end

    def display_guessed_array
        puts @guessed_array.join(' ')
    end

    def display_invalid_guess
        puts "Invalid entry. Please retry."
    end

    def display_gallows
        puts <<~HEREDOC
        +---+
        |   |
            |
            |
            |
            |
      ============
      HEREDOC
    end

end