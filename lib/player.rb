class Player
    def initialize(mark, is_ai) # such as 'x' or 'o'
        @mark = mark
        if @mark == 'x'
            @other = 'o'
        else
            @other = 'x'
            @mark = 'o'
        end
        @is_ai = is_ai
        @choice = 5
    end

    attr_reader :mark
    attr_accessor :choice

    def ai_move(board, game)
        minimax(board, game)
        board.tiles[@choice] = @mark
    end

    def get_score()
        if is_winner?(@mark)
            10
        elsif is_winner?(@other)
            -10
        else
            0
        end
    end

    # leans heavily on https://tinyurl.com/yanf74x8

    def minimax(board, game) #depth can be here
        # p "103: "
        # p Board.method_defined? :is_winner?
        # p board.methods.sort
        if (board.is_winner?(@mark) || board.is_winner?(@other))
            return get_score(@mark)
        end
        # depth += 1
        scores = []
        best_moves = []
        board.available_moves.each do |move|
            scores.push self.minimax(board.make_move(move, @mark), game)
            moves.push move
        end

        # directly from https://tinyurl.com/yanf74x8
        if game.current_player == @mark
            max_score_index = scores.each_with_index.max[1]
            @choice = moves[max_score_index]
            return scores[max_score_index]
        else
           # This is the min calculation
           min_score_index = scores.each_with_index.min[1]
           @choice = moves[min_score_index]
           return scores[min_score_index]
        end
    end

    def take_turn(board, game)
        # only place in unoccupied spot
        # get move location
        # puts @is_ai
        if @is_ai
            # puts 'ai turn'
            # puts board
            ai_move(board, game)
            # p board.methods.sort
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
