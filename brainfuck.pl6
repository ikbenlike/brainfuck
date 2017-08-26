subset UByte of Int where 0 .. 255;

class BrainFuck {
    has UByte @!data[30000] = 0 xx *;
    has Str $.code is rw;
    has Int $!iptr = 0;
    has Int $!dptr = 0;

    method run() {
        #say $.code[4];
        loop ( ; $!iptr < $.code.chars; $!iptr++){
            #say $!iptr;
            given substr($.code, $!iptr, 1) {
                when '>' { $!dptr++; }
                when '<' { $!dptr--; }
                when '+' { @!data[$!dptr]++; }
                when '-' { @!data[$!dptr]--; }
                when '.' { print chr(@!data[$!dptr]); }
                when ',' { @!data[$!dptr] = ord(getc($*IN));}
                when '[' {}
                when ']' {}
                default {}
            }
        }
    }
}

BrainFuck.new(code => slurp @*ARGS[0]).run();
#zsay slurp @*ARGS[0];
my UByte @data[30000];
