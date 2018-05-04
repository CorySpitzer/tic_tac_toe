class Board
    def initialize
        @tiles = [['_', '_', '_'],
                  ['_', '_', '_'],
                  ['_', '_', '_']]
    end

    attr_accessor :tiles

    def place(x, y, mark) # x,y co-ordinates i.e. [1,2]
        @tiles[y, x] = mark
    end

    def is_winner?(player)
        # Check the two diagonals:
        if player.mark == @tiles[1][1]
            if player.mark == @tiles[0][0] && player.mark == @tiles[2][2] ||
               player.mark == @tiles[0][2] && player.mark == @tiles[2][0]
                return true
            end
        # Check the top row or first column
        elsif player.mark == @tiles[0][0]
            # top row
            if player.mark == @tiles[0][1] && player.mark == @tiles[0][2] ||
               # first column
               player.mark == @tiles[1][0] && player.mark == @tiles[2][0]
                return true
            end
        # Check the bottom row or last column
        elsif player.mark == @tiles[2][2]
            # bottom row
            if player.mark == @tiles[2][1] && player.mark == @tiles[2][0] ||
               # last column
               player.mark == @tiles[1][2] && player.mark == @tiles[0][2]
                return true
            end
        else
            false
        end
    end

    def is_occupied?(v, h)
        @tiles[v][h] != '_'
    end

    def print_board
        (0..2).each do |i|
            (0..2).each do |j|
                # puts 'j: ' + j.to_s
                # puts 'i: ' + i.to_s
                # puts "@tiles[i][j]:" + @tiles[i][j]
                print @tiles[i][j] #+ ' '
            end
            puts
        end
    end
end

class Player
    def initialize(mark) # such as 'x' or 'o'
        @mark = mark
    end

    def take_turn(board)
        # only place in unoccupied spot
        # get move location
        while true
            puts "Vertical down 0..2"
            vertical_down = gets.chomp.to_i
            puts "Horizontal across 0..2"
            horizontal_across = gets.chomp.to_i
            if board.is_occupied?(vertical_down, horizontal_across)
                puts "Square already taken, try again"
            else
                board.tiles[vertical_down][horizontal_across] = @mark
                break
            end
        end
        board.print_board
    end

    attr_reader :mark
end

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
        if current_player.mark == 'x'
            current_player = player_o
        else #if current_player.mark == 'o'
            current_player = player_x
        end
    end
end

main()
