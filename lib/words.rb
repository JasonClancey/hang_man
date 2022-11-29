class Words 


    attr_reader :chosen_word_array, :guessed_word_array, :incorrect_letters_used

    require_relative 'display'
    include Display

    def initialize
        @used_letters = []
        @guessed_letter = ''
        @guessed_word_array = []
        @chosen_word_array = []
        @raw_words_array = File.readlines('google-10000-english-no-swears.txt')
        @incorrect_letters_used = 0
    end

    def choose_word
        words_array = []
        @raw_words_array.each { |word| if word.chomp.length >= 5 && word.chomp.length <= 12 then words_array.append(word.chomp.upcase) end }
        @chosen_word_array = words_array.sample.split('')
        @chosen_word_array.length.times { @guessed_word_array.push('_') }
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

    def check_guessed_letter
        @chosen_word_array.each_with_index do |letter, index|
            if @guessed_letter == letter
                @guessed_word_array[index] = @guessed_letter
            end
        end
        if @chosen_word_array.include?(@guessed_letter) == false
            @incorrect_letters_used +=1
        end
        display_used_letters
    end

    #for testing only
    def display_incorrect
        puts @incorrect_letters_used
        display_guessed_array
    end
end

# for puts debugging
word = Words.new
word.choose_word
while true
word.guess_letter
word.check_guessed_letter
word.display_incorrect

end
