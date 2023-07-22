add.clox = '2+2'

Source code from file or repl is loaded into a variable called source which is a pointer to the beggining of code. The source 
is first sent to the compile function which takes the source buffer and loads it into a chunk structure.

```
bool compile(const char* source, Chunk* chunk){
    initScanner(source);
    compilingChunk = chunk;
    
    parser.hadError = false;
    parser.panicMode = false;
    
    advance();
}
```
The function initScanner takes the source buffer and sets the values of the globally declared struct `parser` to the beggining
of the buffer.

```
void initScanner(const char* source){
    scanner.start = source;
    scanner.current = source;
    scanner.line = 1;
}
```

The advance function in compiler.c has the job of advancing the global parser struct. The struct looks like this to start:
```
parser = {
  current = (type = TOKEN_LEFT_PAREN, start = 0x0000000000000000, length = 0, line = 0)
  previous = (type = TOKEN_LEFT_PAREN, start = 0x0000000000000000, length = 0, line = 0)
  hadError = false
  panicMode = false 
}
```
And a Token struct looks like this:

```
TokenType type;
const char* start;
int length;
int line;
```

TokenType is an enumeration of token types like TOKEN_LEFT_PAREN, TOKEN_PLUS, TOKEN_TRUE etc.  

The `advance` function in `compiler.c` repeatedly updates the parser struct's tokens, returning an error 
if a `TOKEN_ERROR` is found. Here's what it looks like:
```
static void advance(){
    parser.previous = parser.current;
    for(;;){
        parser.current = scanToken();
        if(parser.current.type != TOKEN_ERROR) break;
        
        errorAtCurrent(parser.current.start);
    }
    
}
```

scantToken advances the scanner.start pointer and also returns a `Token` struct.
```
Token scanToken(){
    skipWhitespace();
    scanner.start = scanner.current;
    
    if(isAtEnd()) return makeToken(TOKEN_EOF);
    
    char c = advance();
    if(isAlpha(c)) return identifier();
    if(isDigit(c)) return number();
}
```
The advance function in `scanner.c` advances the `scanner.current` pointer and returns the value behind `scanner.current`.
So on the first run, the `scanner.current` pointer gets incremented to point at the `+` character, but then
returns the `2` character. The function then checks if it is a digit and returns a `Token` with type `TOKEN_NUMBER`.

```
static char advance(){
    scanner.current++;
    return scanner.current[-1];
}
```

















