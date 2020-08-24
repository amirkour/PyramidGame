require_relative '../lib/PyramidGame.rb'

RSpec.describe PyramidGame do
    it "exists" do end
    context "intialization" do
        it "initializes" do
            a = PyramidGame.new
            expect(a).to_not be_nil
        end
        it "sets defaults" do
            a = PyramidGame.new
            expect(a.stacks.size).to eq(PyramidGameConstansts::DEFAULT_NUM_STACKS)
            expect(a.num_rings).to eq(PyramidGameConstansts::DEFAULT_NUM_RINGS)
            expect(a.num_moves).to eq(0)
        end
        it "takes args for stacks" do
            num_stacks = PyramidGameConstansts::MAX_NUM_STACKS - 1
            a = PyramidGame.new(:num_stacks => num_stacks)
            expect(a.stacks.size).to eq(num_stacks)
            
            num_stacks = 1
            a = PyramidGame.new(:num_stacks => num_stacks)
            expect(a.stacks.size).to eq(num_stacks)
        end
        it "doesn't let initial number of stacks go out of bounds" do
            num_stacks = PyramidGameConstansts::MAX_NUM_STACKS + 1
            a = PyramidGame.new(:num_stacks => num_stacks)
            expect(a.stacks.size).to_not eq(num_stacks)
            expect(a.stacks.size).to eq(PyramidGameConstansts::DEFAULT_NUM_STACKS)
            
            num_stacks = 0
            a = PyramidGame.new(:num_stacks => num_stacks)
            expect(a.stacks.size).to_not eq(num_stacks)
            expect(a.stacks.size).to eq(PyramidGameConstansts::DEFAULT_NUM_STACKS)
        end
        it "takes args for num rings" do
            num_rings = PyramidGameConstansts::MAX_NUM_RINGS - 1
            a = PyramidGame.new(:num_rings => num_rings)
            expect(a.num_rings).to eq(num_rings)

            num_rings = 1
            a = PyramidGame.new(:num_rings => num_rings)
            expect(a.num_rings).to eq(num_rings)
        end
        it "doesn't let initial number of rings to out of bounds" do
            num_rings = PyramidGameConstansts::MAX_NUM_RINGS + 1
            a = PyramidGame.new(:num_rings => num_rings)
            expect(a.num_rings).to_not eq(num_rings)
            expect(a.num_rings).to eq(PyramidGameConstansts::DEFAULT_NUM_RINGS)

            num_rings = 0
            a = PyramidGame.new(:num_rings => num_rings)
            expect(a.num_rings).to_not eq(num_rings)
            expect(a.num_rings).to eq(PyramidGameConstansts::DEFAULT_NUM_RINGS)
        end
        it "initializes the first stack only/properly" do
            num_stacks = 4
            num_rings = 4
            a = PyramidGame.new(:num_stacks => num_stacks, :num_rings => num_rings)
            expect(a.stacks[0]).to be_a(Array)

            first_stack = a.stacks[0]
            expect(first_stack[0]).to eq(1)
            expect(first_stack[1]).to eq(2)
            expect(first_stack[2]).to eq(3)
            expect(first_stack[3]).to eq(4)
            expect(first_stack[4]).to be_nil

            second_stack = a.stacks[1]
            expect(second_stack).to be_empty
        end
    end

    context "stacks property" do
        it "has a stacks attribute that's an array" do
            a = PyramidGame.new
            expect(a.stacks).to_not be_nil
            expect(a.stacks).to be_a(Array)
        end
    end

    context "num_moves property" do
        it "is an Integer" do
            a = PyramidGame.new
            expect(a.num_moves).to_not be_nil
            expect(a.num_moves).to be_a(Integer)
        end
    end

    context "num_rings property" do
        it "is a Integer" do
            a = PyramidGame.new
            expect(a.num_rings).to_not be_nil
            expect(a.num_rings).to be_a(Integer)
        end
    end

    describe "#valid_move?(x,y)" do
        context "out of bounds args" do
            it "returns false" do
                num_stacks = 3
                a = PyramidGame.new(:num_stacks => num_stacks, :num_rings => 3)
                expect(a.valid_move?(-1,2)).to be false
                expect(a.valid_move?(0, num_stacks)).to be false
            end
        end
        context "for an invalid move" do
            it "returns false" do
                num_stacks = 3
                a = PyramidGame.new(:num_stacks => num_stacks, :num_rings => 3)
                
                # bigger on top of smaller
                a.instance_variable_set(:@stacks, [[2,3],[1],[]])
                expect(a.valid_move?(0,1)).to be false

                # move from an empty stack
                a.instance_variable_set(:@stacks, [[],[1,2,3],[]])
                expect(a.valid_move?(0,1)).to be false
            end
        end
        context "for noninteger args" do
            it "return false" do
                a = PyramidGame.new
                expect(a.valid_move?("hi",1)).to be false
                expect(a.valid_move?(0,"hi")).to be false
            end
        end
    end

    describe "#make_move(x,y)" do
        context "with out of bounds args" do
            it "returns false" do
                num_stacks = 3
                stacks = [[1,2,3],[],[]]
                a = PyramidGame.new(:num_stacks => num_stacks, :num_rings => 3)
                a.instance_variable_set(:@stacks, stacks)

                expect(a.make_move(-1,2)).to be false
                expect(a.stacks).to eq(stacks)

                expect(a.make_move(0, num_stacks)).to be false
                expect(a.stacks).to eq(stacks)
            end
        end
        context "for an invalid move" do
            it "returns false" do
                num_stacks = 3
                a = PyramidGame.new(:num_stacks => num_stacks, :num_rings => 3)
                
                # bigger on top of smaller
                stacks = [[2,3],[1],[]]
                a.instance_variable_set(:@stacks, stacks)
                expect(a.make_move(0,1)).to be false
                expect(a.stacks).to eq(stacks)

                # move from an empty stack
                stacks = [[],[1,2,3],[]]
                a.instance_variable_set(:@stacks, stacks)
                expect(a.make_move(0,1)).to be false
                expect(a.stacks).to eq(stacks)
            end
        end
        context "for noninteger args" do
            it "return false" do
                num_stacks = 3
                a = PyramidGame.new(:num_stacks => num_stacks, :num_rings => 3)

                stacks = [[1,2,3],[],[]]
                a.instance_variable_set(:@stacks, stacks)
                expect(a.make_move("hi",1)).to be false
                expect(a.stacks).to eq(stacks)

                expect(a.make_move(0,"hi")).to be false
                expect(a.stacks).to eq(stacks)
            end
        end
        context "for a valid move" do
            it "returns true and updates the stacks" do
                num_stacks = 3
                a = PyramidGame.new(:num_stacks => num_stacks, :num_rings => 3)

                stacks = [[1,2,3],[],[]]
                a.instance_variable_set(:@stacks, stacks)
                expect(a.make_move(0,1)).to be true
                expect(a.stacks).to eq([[2,3],[1],[]])

                expect(a.make_move(1,2)).to be true
                expect(a.stacks).to eq([[2,3],[],[1]])

                expect(a.make_move(0,1)).to be true
                expect(a.stacks).to eq([[3],[2],[1]])

                expect(a.make_move(2,1)).to be true
                expect(a.stacks).to eq([[3],[1,2],[]])

                expect(a.make_move(0,2)).to be true
                expect(a.stacks).to eq([[],[1,2],[3]])

                expect(a.make_move(1,0)).to be true
                expect(a.stacks).to eq([[1],[2],[3]])

                expect(a.make_move(1,2)).to be true
                expect(a.stacks).to eq([[1],[],[2,3]])

                expect(a.make_move(0,2)).to be true
                expect(a.stacks).to eq([[],[],[1,2,3]])
            end
        end
    end

    describe "game_over?" do
        before do
            @num_stacks = 3
            @a = PyramidGame.new(:num_stacks => @num_stacks, :num_rings => 3)

            @stacks = [[1,2,3],[],[]]
            @a.instance_variable_set(:@stacks, @stacks)
        end
        context "when the game isn't over" do
            it "returns false" do
                expect(@a.game_over?).to be false

                @stacks = [[1],[2],[3]]
                @a.instance_variable_set(:@stacks, @stacks)
                expect(@a.game_over?).to be false

                @stacks = [[1],[],[2,3]]
                @a.instance_variable_set(:@stacks, @stacks)
                expect(@a.game_over?).to be false

                @stacks = [[],[],[3,1,2]]
                @a.instance_variable_set(:@stacks, @stacks)
                expect(@a.game_over?).to be false
            end
        end
        context "when the game is over" do
            it "returns true" do
                @stacks = [[],[],[1,2,3]]
                @a.instance_variable_set(:@stacks, @stacks)
                expect(@a.game_over?).to be true

                @stacks = [[],[],[1,1,1]]
                @a.instance_variable_set(:@stacks, @stacks)
                expect(@a.game_over?).to be true

                a = PyramidGame.new(:num_rings => 1, :num_stacks => 1)
                expect(a.game_over?).to be true

                a = PyramidGame.new(:num_rings => 2, :num_stacks => 1)
                expect(a.game_over?).to be true
            end
        end
    end
end