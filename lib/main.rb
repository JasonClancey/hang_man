require_relative 'display'
require_relative 'game'
require_relative 'words'

include Display

def play_hangman
    game = Game.new
    game.gameplay_loop
end

play_hangman