class Words 

    attr_reader :chosen_word

    def initialize
        @chosen_word = ''
        @guessed_letter = ''
        @raw_words_array = File.readlines('google-10000-english-no-swears.txt')
    end

    def choose_word
        words_array = []
        @raw_words_array.each { |word| if word.chomp.length >= 5 && word.chomp.length <= 12 then words_array.append(word) end }
        @chosen_word = words_array.sample.split('')
    end

    def guess_letter
        puts "Please enter a letter: "
        @guessed_letter = gets.chomp.case
    end
end
