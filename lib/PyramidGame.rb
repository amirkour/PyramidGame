module PyramidGameConstansts
    DEFAULT_NUM_RINGS = 5
    MAX_NUM_RINGS = 10
    DEFAULT_NUM_STACKS = 3
    MAX_NUM_STACKS = 5
end

class PyramidGame
    attr_reader :stacks, :num_moves, :num_rings

    def initialize(options = {
        :num_rings => PyramidGameConstansts::DEFAULT_NUM_RINGS,
        :num_stacks => PyramidGameConstansts::DEFAULT_NUM_STACKS
    })
        options = options.nil? || !options.kind_of?(Hash) ? {} : options

        @num_rings = options[:num_rings].kind_of?(Integer) ? options[:num_rings] : PyramidGameConstansts::DEFAULT_NUM_RINGS
        @num_rings = PyramidGameConstansts::DEFAULT_NUM_RINGS unless @num_rings > 0 && @num_rings <= PyramidGameConstansts::MAX_NUM_RINGS

        num_stacks = options[:num_stacks].kind_of?(Integer) ? options[:num_stacks] : PyramidGameConstansts::DEFAULT_NUM_STACKS
        num_stacks = PyramidGameConstansts::DEFAULT_NUM_STACKS unless num_stacks > 0 && num_stacks <= PyramidGameConstansts::MAX_NUM_STACKS
        
        @stacks = []
        first_stack = []
        @num_rings.times { |x| first_stack.push(x+1) }

        @stacks.push(first_stack)
        (num_stacks - 1).times { @stacks.push([]) }

        @num_moves = 0
    end

    def make_move(x,y)
        return false unless valid_move?(x,y)

        origin = @stacks[x]
        destination = @stacks[y]
        destination.unshift(origin.shift)

        true
    end

    def valid_move?(x,y)
        return false unless x.kind_of?(Integer) && y.kind_of?(Integer)
        return false unless x >= 0 && x < @stacks.size && y >= 0 && y < @stacks.size
        return true if x == y

        origin = @stacks[x]
        destination = @stacks[y]

        return false unless origin.size > 0
        return false if destination.size > 0 && origin[0] > destination[0]

        true
    end

    def game_over?
        return true if @stacks.nil? || @stacks.size <= 0 || @num_rings <= 0
        return true if @stacks.size == 1 && @num_rings == 1

        last_stack = @stacks[@stacks.size - 1]
        return false unless last_stack.size == @num_rings

        i=0
        j=1
        while j < last_stack.size
            return false if last_stack[i] > last_stack[j]
            i = i + 1
            j = j + 1
        end

        true
    end
end
