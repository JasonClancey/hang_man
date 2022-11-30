class Words 

    attr_reader :chosen_word_array, :guessed_word_array, :incorrect_letters_used, :guessed_letter, :used_letters

    require_relative 'display'
    include Display

    def initialize
        @used_letters = []
        @guessed_letter = ''
        @guessed_word_array = []
        @chosen_word_array = []
        @raw_words_array = File.readlines('google-10000-english-no-swears.txt')
    end

    def choose_word
        words_array = []
        @raw_words_array.each { |word| if word.chomp.length >= 5 && word.chomp.length <= 12 then words_array.append(word.chomp.upcase) end }
        @chosen_word_array = words_array.sample.split('')
        @chosen_word_array.length.times { @guessed_word_array.push('_') }
        @raw_words_array = []
    end

    def guess_letter
        active = true
        request_player_guess
        @guessed_letter = gets.chomp.upcase
            while active
                if /[A-Z]/ =~ @guessed_letter && @used_letters.include?(@guessed_letter) == false && @guessed_letter.length == 1
                    active = false
                else
                    display_invalid_guess
                    @guessed_letter = gets.chomp.upcase
                end
            end
        @used_letters.push(@guessed_letter)
    end
end

