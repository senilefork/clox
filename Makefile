# -*- MakeFile -*-
CC = cc
CFLAGS = -g -c 

OBJS = chunk.o compiler.o debug.o main.o memory.o scanner.o vm.o value.o 
EXEC = run

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(OBJS) -o $(EXEC)

chunk.o: chunk.c
	$(CC) $(CFLAGS) chunk.c

compiler.o: compiler.c
	$(CC) $(CFLAGS) compiler.c

debug.o: debug.c
	$(CC) $(CFLAGS) debug.c

main.o: main.c 
	$(CC) $(CFLAGS) main.c

memory.o: memory.c
	$(CC) $(CFLAGS) memory.c

scanner.o: scanner.c
	$(CC) $(CFLAGS) scanner.c 

value.o: value.c
	$(CC) $(CFLAGS) value.c

vm.o: vm.c
	$(CC) $(CFLAGS) vm.c

clean:
	rm -f $(OBJS) $(EXEC)
