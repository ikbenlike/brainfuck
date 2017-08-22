with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Direct_IO;
with Ada.Directories;
with Ada.Command_Line;
with Ada.Strings.Unbounded;


procedure Brainfuck is

    package war is
        
    end war;

    function readfile(fname : String) return String is
        fsize : constant Natural := Natural(Ada.Directories.Size(fname)); 
        subtype FileString is String(1 .. fsize);
        package fsio is new Ada.Direct_IO(FileString);

        file : fsio.File_Type;
        contents : FileString;
    begin
        fsio.Open(file, Mode => fsio.In_File, name => fname);
        fsio.Read(file, Item => contents);
        fsio.Close(file);
        return String(contents);
    end readfile;

    type Byte is range 0 .. 255;
    type ByteArray is array(Natural range <>) of Byte;

    type brainfuck_t(size : Natural := 30000) is 
        record
            data : ByteArray(1 .. size);
            iptr : Natural := 1;
            dptr : Natural := 1;
        end record;

    bf : brainfuck_t;

    code : Ada.Strings.Unbounded.Unbounded_String;
    code_L : Natural;
    index : Natural := 1;
    count : Integer := 1;
    tmp_str : String(1 .. 2);

begin
    if Ada.Command_Line.Argument_Count < 1 then 
        Ada.Text_IO.Put_Line("Error: please provide a file to interpret");
        Ada.Command_Line.Set_Exit_Status(1);
        return;
    end if;

    code := Ada.Strings.Unbounded.To_Unbounded_String(readfile(Ada.Command_Line.Argument(Number => 1)));
    code_L := Ada.Strings.Unbounded.Length(code);

    while bf.iptr < code_L loop 
        case Ada.Strings.Unbounded.Element(code, bf.iptr) is
            when '>' =>
                bf.dptr := bf.dptr + 1;
            when '<' =>
                bf.dptr := bf.dptr - 1;
            when '+' =>
                bf.data(bf.dptr) := bf.data(bf.dptr) + 1;
            when '-' =>
                bf.data(bf.dptr) := bf.data(bf.dptr) + 1;
            when '.' =>
                Ada.Text_IO.Put(Character'Val(bf.data(bf.dptr)));
            when ',' =>
                Ada.Text_IO.Get(tmp_str);
                bf.data(bf.dptr) := Character'Pos(tmp_str(1));
            when '[' =>
                if bf.data(bf.dptr) = 0 then
                    bf.iptr := bf.iptr + 1;
                    while count > 0 loop
                        if Ada.Strings.Unbounded.Element(code, bf.iptr) = '[' then
                            count := count + 1;
                        elsif Ada.Strings.Unbounded.Element(code, bf.iptr) = ']' then
                            count := count - 1;
                        end if;
                        bf.iptr := bf.iptr + 1;
                    end loop;
                    bf.iptr := bf.iptr - 1;
                end if;
            when ']' =>
                if bf.data(bf.dptr) /= 0 then
                    bf.iptr := bf.iptr - 1;
                    while count > 0 loop
                        if Ada.Strings.Unbounded.Element(code, bf.iptr) = ']' then
                            count := count + 1;
                        elsif Ada.Strings.Unbounded.Element(code, bf.iptr) = '[' then
                            count := count - 1;
                        end if;
                        bf.iptr := bf.iptr - 1;
                    end loop;
                end if;
            when others => NULL;
        end case;
        bf.iptr := bf.iptr + 1;
    end loop;

end Brainfuck;
