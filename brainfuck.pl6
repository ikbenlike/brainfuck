class BrainFuck {
    subset UByte of Int where 0 .. 255;
    has UByte @!data[30000] = 0 xx *;
    has Str $.code is rw;
    has Int $!iptr = 0;
    has Int $!dptr = 0;

    method run() {
        loop ( ; $!iptr < $!code.chars; $!iptr++){
            my $count = 1;
            given substr($!code, $!iptr, 1) {
                when '>' { $!dptr++; }
                when '<' { $!dptr--; }
                when '+' { @!data[$!dptr]++; }
                when '-' { @!data[$!dptr]--; }
                when '.' { print chr(@!data[$!dptr]); }
                when ',' { @!data[$!dptr] = ord(getc($*IN));}
                when '[' {
                    if @!data[$!dptr] == 0 {
                        $!iptr++;
                        while $count > 0 {
                            if (substr($!code, $!iptr, 1) eq '[') { $count++; };
                            if (substr($!code, $!iptr, 1) eq ']') { $count--; };
                            $!iptr++;
                        }
                        $!iptr--;
                    }
                }
                when ']' {
                    if @!data[$!dptr] != 0 {
                        $!iptr--;
                        while $count > 0 {
                            if substr($!code, $!iptr, 1) eq ']' { $count++; };
                            if substr($!code, $!iptr, 1) eq '[' { $count--; }; 
                            $!iptr--;
                        }
                    }
                }
            }
        }
    }
}

BrainFuck.new(code => slurp @*ARGS[0]).run();
