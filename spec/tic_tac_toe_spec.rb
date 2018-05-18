#!/usr/bin/env ruby2.3

require "../board"

describe Board do
    # describe "#print_board" do
    #     context "without any input" do
    #         it "returns a representation of the board" do
    #             expect(Board.new.print_board).to output("\n___\n___\n___").to_stdout
    #         end
    #     end
    # end
    describe "#draw" do
        context "with a full board and no winner" do
            it "returns true" do
                board = Bored.new
                board.tiles = ['o', 'o', 'x',
                               'o', 'x', 'x',
                               'x', 'o', 'o']
                expect(board.draw).to eql true
            end
        end
    end

end
#
# describe Player do
#
# end
