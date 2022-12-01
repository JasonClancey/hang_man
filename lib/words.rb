class Words 

    attr_accessor :used_letters, :guessed_word_array, :chosen_word_array, :guessed_letter

    require_relative 'display'

    include Display

    def initialize(used_letters = [], guessed_word_array = [], chosen_word_array = [])
        @used_letters = used_letters
        @guessed_letter = ''
        @guessed_word_array = guessed_word_array
        @chosen_word_array = chosen_word_array
        @raw_words_array = File.readlines('google-10000-english-no-swears.txt')
    end

    def choose_word
        words_array = []
        @raw_words_array.each { |word| if word.chomp.length >= 5 && word.chomp.length <= 12 then words_array.append(word.chomp.upcase) end }
        @chosen_word_array = words_array.sample.split('')
        @chosen_word_array.length.times { @guessed_word_array.push('_') }
        @raw_words_array = []
    end

end

