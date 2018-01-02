import java.io.IOException;
import java.nio.file.*;

class Main {
    
    public static class BrainFuck {
        private String code;
        private int iptr;
        private byte[] data;
        private int dptr;

        public BrainFuck(String c){
            this.code = c;
            this.iptr = 0;
            this.data = new byte[30000];
            this.dptr = 0;
        }

        public void run() throws IOException {
            while(this.iptr < this.code.length()){
                int count = 1;
                switch(this.code.charAt(this.iptr)){
                    case '>':
                        this.dptr++;
                        break;
                    case '<':
                        this.dptr--;
                        break;
                    case '+':
                        this.data[this.dptr]++;
                        break;
                    case '-':
                        this.data[this.dptr]--;
                        break;
                    case '.':
                        System.out.print(Character.toString((char)this.data[this.dptr]));
                        break;
                    case ',':
                        this.data[this.dptr] = (byte)System.in.read();
                        break;
                    case '[':
                        count = 1;
                        if(this.data[this.dptr] == 0){
                            this.iptr++;
                            while(count > 0){
                                if(this.code.charAt(this.iptr) == '['){
                                    count++;
                                }
                                else if(this.code.charAt(this.iptr) == ']'){
                                    count--;
                                }
                                this.iptr++;
                            }
                            this.iptr--;
                        }
                        break;
                    case ']':
                        count = 1;
                        if(this.data[this.dptr] != 0){
                            this.iptr--;
                            while(count > 0){
                                if(this.code.charAt(this.iptr) == ']'){
                                    count++;
                                }
                                else if(this.code.charAt(this.iptr) == '['){
                                    count--;
                                }
                                this.iptr--;
                            }
                        }
                        break;
                    default:
                        break;
                }
                this.iptr++;
            }
        }
    }

    public static void main(String[] args) throws IOException {
        String _c = new String(Files.readAllBytes(Paths.get(args[1])));
        BrainFuck bf = new Main.BrainFuck(_c);
        bf.run();
    }
}