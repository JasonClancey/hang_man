class Words 

    attr_reader :guessed_array
    require_relative 'display'
    include Display

    def initialize
        @guessed_letter = ''
        @guessed_array = []
        @chosen_word_array = []
        @raw_words_array = File.readlines('google-10000-english-no-swears.txt')
    end

    def choose_word
        words_array = []
        @raw_words_array.each { |word| if word.chomp.length >= 5 && word.chomp.length <= 12 then words_array.append(word.chomp.upcase) end }
        @chosen_word_array = words_array.sample.split('')
        @chosen_word_array.length.times {@guessed_array.push('_')}
    end

    def guess_letter
        request_player_guess
        @guessed_letter = gets.chomp.upcase
        unless /[A-Z]/ =~ @guessed_letter
            display_invalid_guess
            guess_letter
        end
    end

    def check_guessed_letter
        @chosen_word_array.each_with_index do |letter, index|
            if @guessed_letter == letter
                @guessed_array[index] = @guessed_letter
            end
        end
    end
end

word = Words.new
word.choose_word
word.guess_letter
word.check_guessed_letter