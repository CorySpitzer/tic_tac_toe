class Game
    def initialize(is_ai)
        @is_ai = is_ai
        @current_player = nil
    end

    attr_accessor :current_player

    def play()
        board = Board.new
        # board.print_board
        winner = false
        player_x = Player.new('x', @is_ai) #AI
        puts 'x is AI'
        # puts "ai true" if @is_ai
        player_o = Player.new('o', false)
        # who goes first?
        @current_player = player_x
        while !winner
            # puts "board: " + board
            # p board.methods.sort
            @current_player.take_turn(board, self)
            winner = board.is_winner? @current_player.mark
            if winner
                puts "The " + @current_player.mark + " player won!"
            elsif board.draw
                winner = false
                puts "It's a draw!"
            end
            if @current_player.mark == 'x'
                @current_player = player_o
            else #if @current_player.mark == 'o'
                @current_player = player_x
            end
        end
    end
end
