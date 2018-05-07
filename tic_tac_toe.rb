require_relative "lib/board"
require_relative "lib/player"
require_relative "lib/game"

def main()
    while true
        puts "Play against AI or just humans? 'h' for humans"
        if gets.chomp.downcase == 'h'
            Game.new(false).play()
        else
            Game.new(true).play()
        end
        puts "Press 'p' to play again"
        if gets.chomp.downcase != 'p'
            break
        end
    end

end

main()
