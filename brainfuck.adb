with Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Directories;
with Ada.Command_Line;
with Ada.Strings.Unbounded;

procedure Brainfuck is

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
    type ByteArray is array(Integer range <>) of Byte;

    type brainfuck_t(size : Integer := 30000) is 
        record
            data : ByteArray(0 .. size);
            iptr : Integer := 0;
            dptr : Integer := 0;
        end record;

    brainfuck : brainfuck_t(30000);

    code : Ada.Strings.Unbounded.Unbounded_String;

begin
    code := Ada.Strings.Unbounded.To_Unbounded_String(readfile(Ada.Command_Line.Argument(Number => 1)));
    --Ada.Text_IO.Put(readfile(Ada.Command_Line.Argument(Number => 1)));
end Brainfuck;
