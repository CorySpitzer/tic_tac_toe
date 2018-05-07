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

class Player
    def initialize(mark, is_ai) # such as 'x' or 'o'
        @mark = mark
        if @mark == 'x'
            @other = 'o'
        else
            @other = 'x'
        @is_ai = is_ai
        end
    end

    attr_reader :mark

    # def ai_move(board)
    #     board.tiles[0][0]
    # end

    # The following minimax leans heavily on https://tinyurl.com/yanf74x8
    # Node = Struct.new(:score, :move)
    #
    # def minmax(board, lowerbound, upperbound)
    #     if board.is_winner? @mark || board.is_winner? @other
    #         return get_score(@mark)
    #     end
    #     candidate_move_nodes = []
    #     board.moves.each do |move|
    #         child_board = board.make_move(move, @mark)
    #         score = minmax(child_board, lower_bound, upper_bound)
    #         node = Node.new(score, move)
    #         candidate_move_nodes << node
    #     end
    #
    # end
    #
    # def get_score()
    #     if is_winner?(@mark)
    #         10
    #     elsif is_winner?(@other)
    #         -10
    #     else
    #         0
    #     end
    # end

    # leans heavily on https://tinyurl.com/yanf74x8
    # def minimax(game, depth)
    #     return score(game) if game.over?
    #     depth += 1
    #     scores = [] # an array of scores
    #     moves = []  # an array of moves
    #
    #     # Populate the scores array, recursing as needed
    #     game.get_available_moves.each do |move|
    #         possible_game = game.get_new_state(move)
    #         scores.push minimax(possible_game, depth)
    #         moves.push move
    #     end
    #
    #     # Do the min or the max calculation
    #     if game.active_turn == @player
    #         # This is the max calculation
    #         max_score_index = scores.each_with_index.max[1]
    #         @choice = moves[max_score_index]
    #         return scores[max_score_index]
    #     else
    #         # This is the min calculation
    #         min_score_index = scores.each_with_index.min[1]
    #         @choice = moves[min_score_index]
    #         return scores[min_score_index]
    #     end
    # end

    # def minimax(board)
    #     if board.is_winner? @mark || board.is_winner? @other
    #         return get_score(@mark)
    #     best_moves = []
    #
    # end

    def take_turn(board)
        # only place in unoccupied spot
        # get move location
        if @is_ai
            ai_move(board)
        else # humans
            while true
                # move = -1
                while true
                    puts "Select move 1..9"
                    move = gets.chomp.to_i - 1
                    if move >= 0 && move <= 8
                        break
                    end
                    puts "Try again"
                end
                if board.is_occupied?(move)
                    puts "Square already taken, try again"
                else
                    board.tiles[move] = @mark
                    break
                end
            end
        end
        board.print_board
    end
end

class Game
    def initialize(is_ai)
        @is_ai = is_ai
    end

    def play()
        board = Board.new
        # board.print_board
        winner = false
        player_x = Player.new('x', @is_ai) #AI
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
