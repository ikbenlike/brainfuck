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
            count = 1
            case @code[@iptr]
                when '>' then @dptr += 1
                when '<' then @dptr -= 1
                when '+' then @data[@dptr] += 1
                when '-' then @data[@dptr] -= 1
                when '.' then print @data[@dptr].chr
                when ',' then @data[@dptr] = STDIN.gets.chomp[0].ord
                when '['
                    if @data[@dptr] == 0 then
                        @iptr += 1
                        while count > 0
                            count += 1 if @code[@iptr] == '['
                            count -= 1 if @code[@iptr] == ']'
                            @iptr += 1
                        end
                        @iptr -= 1
                    end
                when ']'
                    if @data[@dptr] != 0 then
                        @iptr -= 1
                        while count > 0
                            count += 1 if @code[@iptr] == ']'
                            count -= 1 if @code[@iptr] == '['
                            @iptr -= 1
                        end
                    end
            end
            @iptr += 1
        end
    end
end

BrainFuck.new(File.read(ARGV[0])).run()
