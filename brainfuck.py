import sys

def read_file(path : str) -> str:
    with open(path, "r") as f:
        return f.read()

class BrainFuck:
    def __init__(self, ds : int = 30000, code : str = ""):
        self.data = [int()] * ds
        self.code = code
        self.dptr = 0
        self.iptr = 0

    def run(self):
        p_MAX = len(self.code)

        while self.iptr < p_MAX:
            count = 1
            if self.code[self.iptr] == '>':
                self.dptr += 1

            elif self.code[self.iptr] == '<':
                self.dptr -= 1

            elif self.code[self.iptr] == '+':
                self.data[self.dptr] += 1

            elif self.code[self.iptr] == '-':
                self.data[self.dptr] -= 1

            elif self.code[self.iptr] == '.':
                print(chr(self.data[self.dptr]), end="")

            elif self.code[self.iptr] == ',':
                self.data[self.dptr] = chr(input("")[0])

            elif self.code[self.iptr] == '[':
                if not self.data[self.dptr]:
                    self.iptr += 1
                    while count > 0:
                        if self.code[self.iptr] == '[':
                            self.count += 1
                        elif self.code[self.iptr] == ']':
                            self.count -= 1
                        self.iptr += 1
                    self.iptr -= 1

            elif self.code[self.iptr] == ']':
                if self.data[self.dptr]:
                    self.iptr -= 1
                    while count > 0:
                        if self.code[self.iptr] == ']':
                            count += 1
                        elif self.code[self.iptr] == '[':
                            count -= 1
                        self.iptr -= 1

            self.iptr += 1


bf = BrainFuck(code = read_file(sys.argv[1]))
bf.run()
