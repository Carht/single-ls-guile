CC 	= gcc
CFLAGS 	= -Wall -g -std=c99 $(shell pkg-config --cflags guile-3.0)
LDFLAGS = $(shell pkg-config --libs guile-3.0)

SRC	= main.c
OBJ	= $(SRC:.c=.o)
PROG	= listdirr

all:	$(PROG)

$(PROG):	$(OBJ)
	$(CC) $(OBJ) -o $(PROG) $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(PROG)
