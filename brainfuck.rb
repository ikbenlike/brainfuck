file = ARGV[0]

class BrainFuck
    def initialize(code)
        @code = code
        @iptr = 0
        @dptr = 0
        @data = Array.new(30000){0}
    end

    def run()
        len = @code.length
        while @iptr < len
            case @code[@iptr]
                when '>' then @dptr += 1
                when '<' then @dptr -= 1
                when '+' then @data[@dptr] += 1
                when '-' then @data[@dptr] -= 1
                when '.' then print @data[@dptr].chr
                when ',' then nil
                when '[' then nil
                when ']' then nil
            end
            @iptr += 1
        end
    end
end

bf = BrainFuck.new(File.read(file))
bf.run()
