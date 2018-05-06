class Board
    def initialize
        @tiles = [['_', '_', '_'],
                  ['_', '_', '_'],
                  ['_', '_', '_']]
        @moves = []
    end

    attr_accessor :tiles, :moves

    def is_winner?(mark)
        # Check the two diagonals:
        if mark == @tiles[1][1]
            if mark == @tiles[0][0] && mark == @tiles[2][2] ||
               mark == @tiles[0][2] && mark == @tiles[2][0]
                return true
            end
        # Check the top row or first column
        elsif mark == @tiles[0][0]
            # top row
            if mark == @tiles[0][1] && mark == @tiles[0][2] ||
               # first column
               mark == @tiles[1][0] && mark == @tiles[2][0]
                return true
            end
        # Check the bottom row or last column
        elsif mark == @tiles[2][2]
            # bottom row
            if mark == @tiles[2][1] && mark == @tiles[2][0] ||
               # last column
               mark == @tiles[1][2] && mark == @tiles[0][2]
                return true
            end
        else
            false
        end
    end

    def make_move(move, mark)
        self.tiles[move[1]][move[0]] = mark
    end

    def available_moves()
        (0..2).each do |i|
            (0..2).each do |j|
                if @tiles[j][i] == '_'
                    @moves << [j, i]
                end
            end
        end
        @moves
    end

    def is_occupied?(v, h)
        @tiles[v][h] != '_'
    end

    def print_board
        puts
        (0..2).each do |i|
            (0..2).each do |j|
                print @tiles[i][j]
            end
            puts
        end
        puts
    end
end

class Player
    def initialize(mark, is_ai) # such as 'x' or 'o'
        @mark = mark
        if @mark == 'x'
            @other = 'o'
        else
            @other = 'x'
        @is_ai = is_ai
    end

    # def ai_move(board)
    #     board.tiles[0][0]
    # end

    def minimax(board, lowerbound, upperbound)
        # while true
        #     vertical_down = rand 3
        #     horizontal_across = rand 3
        #     if !board.is_occupied?(vertical_down, horizontal_across)
        #         board.tiles[vertical_down][horizontal_across] = @mark
        #         break
        #     end
        # end

        # The following minimax leans heavily on https://tinyurl.com/yanf74x8
        if board.is_winner? @mark || board.is_winner? @other
            return get_score(@mark)
        end
        candidate_move_nodes = []
        board.moves.each do |move|
            child_board = board.make_move(move)
        end

    end

    def get_score()
        if is_winner?(@mark)
            @base_score
        elsif is_winner?(@other)
            -@base_score
        else
            0
        end
    end

    def take_turn(board)
        # only place in unoccupied spot
        # get move location
        if @is_ai
            ai_move(board)
        else # humans
            while true
                vertical_down = -1
                while true
                    puts "Vertical down 1..3"
                    vertical_down = gets.chomp.to_i - 1
                    if vertical_down >= 0 && vertical_down <= 2
                        break
                    end
                    puts "Try again"
                end
                while true
                    puts "Horizontal across 1..3"
                    horizontal_across = gets.chomp.to_i - 1
                    if horizontal_across >= 0 && horizontal_across <= 2
                        break
                    end
                    puts "Try again"
                end
                if board.is_occupied?(vertical_down, horizontal_across)
                    puts "Square already taken, try again"
                else
                    board.tiles[vertical_down][horizontal_across] = @mark
                    break
                end
            end
        end
        board.print_board
    end

    attr_reader :mark
end

class Game
    def initialize()
        # @is_ai = is_ai
    end

    def play(is_ai)
        board = Board.new
        # board.print_board
        winner = false
        player_x = Player.new('x', is_ai) #AI
        player_o = Player.new('o', false)
        # who goes first?
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
end
