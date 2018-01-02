build:
	gnatmake brainfuck.adb -o ./build/brainfuck-ada.exe
	gcc brainfuck.c -o ./build/brainfuck-c.exe
	dmd brainfuck.d -o- -of./build/brainfuck-d.exe
	fsc brainfuck.fs -o ./build/brainfuck-fs.exe
	javac brainfuck.java -d ./build
	mv ./build/Main.class ./build/brainfuck-java.class
	rm ./build/Main$$BrainFuck.class
	rustc brainfuck.rs -o ./build/brainfuck-rs.exe

.PHONY: clean

clean:
	rm ./build/*.exe
	rm ./build/*.class
	rm ./build/*.dll
	rm ./build/*.pdb
	rm *.ali
	rm *.o
