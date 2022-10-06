class Words 

raw_words_list = File.readlines('google-10000-english-no-swears.txt')

words_list = []

raw_words_list.each { |word| if word.chomp.length >= 5 && word.length <= 12 then words_list.append(word) end }

chosen_word = words_list.sample.split('')

end