require_relative "lib/tic_tac_toe_lib"

def main()
    board = Board.new
    # board.print_board
    winner = false
    player_x = Player.new('x')
    player_o = Player.new('o')
    current_player = player_x
    while !winner
        current_player.take_turn(board)
        winner = board.is_winner? current_player
        if winner
            puts "The " + current_player.mark + " player won!"
        end
        if current_player.mark == 'x'
            current_player = player_o
        else #if current_player.mark == 'o'
            current_player = player_x
        end
    end
end

main()
