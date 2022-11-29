module Display

    def request_player_guess
        puts "Please enter a letter: "
    end

    def display_guessed_array
        puts @guessed_array.join(' ')
    end

    def display_invalid_guess
        puts "Invalid entry. Please retry."
    end

end