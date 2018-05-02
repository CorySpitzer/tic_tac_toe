class Board
    def initialize
        @tiles = [['_', '_', '_'],
                  ['_', '_', '_'],
                  ['_', '_', '_']]
    end

    def place(x, y, mark) # x,y co-ordinates i.e. [1,2]
        @tiles[y, x] = mark
    end

    def is_winner?

    end
end

def main()
    board = Board.new
    winner = false
    while !winner
        current_player.take_turn
        winner = board.is_winner?
    end
end

main()
