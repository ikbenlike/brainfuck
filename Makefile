build-windows:
	gnatmake brainfuck.adb -o ./build/brainfuck-ada.exe
	gcc brainfuck.c -o ./build/brainfuck-c.exe
	dmd brainfuck.d -of./build/brainfuck-d.exe
	fsc brainfuck.fs -o ./build/brainfuck-fs.exe
	javac brainfuck.java -d ./build
	powershell.exe -Command "cmd /c 'vcvarsall.bat amd64 & odin.exe build brainfuck.odin'"	
	mv brainfuck.exe ./build/brainfuck-odin.exe
	#yes, this has to be done this way;
	#cmd.exe doesn't like to be called
	#with /c from make
	rustc brainfuck.rs -o ./build/brainfuck-rs.exe											

.PHONY: clean

clean:
	rm ./build/*.exe
	rm ./build/*.class
	rm ./build/*.dll
	rm ./build/*.pdb
	rm *.ali
	rm *.o
