require_relative "lib/tic_tac_toe_lib"

def main()
    while true
        puts "Play against AI or just humans? 'h' for humans"
        if gets.chomp.downcase == 'h'
            Game.new.play('human')
        else
            Game.new.play('ai')
        end
        puts "Press 'p' to play again"
        if gets.chomp.downcase != 'p'
            break
        end
    end

end

main()
