class Board
    def initialize
        @tiles = ['_', '_', '_',
                  '_', '_', '_',
                  '_', '_', '_']
        @moves = []
    end

    attr_accessor :tiles, :moves

    def is_winner?(mark)
        # Check the two diagonals:
        if mark == @tiles[4]
            if mark == @tiles[0] && mark == @tiles[8] ||
               mark == @tiles[6] && mark == @tiles[2]
                return true
            end
        # Check the top row or first column
        elsif mark == @tiles[0]
            # top row
            if mark == @tiles[1] && mark == @tiles[2] ||
               # first column
               mark == @tiles[3] && mark == @tiles[6]
                return true
            end
        # Check the bottom row or last column
        elsif mark == @tiles[8]
            # bottom row
            if mark == @tiles[6] && mark == @tiles[7] ||
               # last column
               mark == @tiles[2] && mark == @tiles[5]
                return true
            end
        else
            false
        end
    end

    def game_over?(mark)
        is_winner? mark || draw?
    end

    def draw()
        if !(is_winner?('x') || is_winner?('o')) &&
            self.available_moves.length == 0
            true
        end
        false
    end

    def make_move(move, mark)
        # puts move
        @tiles[move] = mark
        self
    end

    def available_moves()
        (0..8).each do |i|
            if @tiles[i] == '_'
                p "i: " + i.to_s
                p "@tiles[i] == '_'"
                @moves << i
            end
        end
        @moves
    end

    def is_occupied?(move)
        @tiles[move] != '_'
    end

    def print_board
        puts
        (0..8).each do |i|
            print @tiles[i]
            if (i + 1) % 3 == 0
                puts
            end
        end
        puts
    end
end
