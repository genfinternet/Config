SRC = #Source file
TARGET = #Target
TESTSUIT = #test suite
CC = gcc
OBJ = $(SRC:.c=.o)
CFLAGS = -Werror -Wall -Wextra -pedantic -std=c99

.PHONY: all
all:$(TARGET)
	
$(TARGET):$(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $(TARGET)

.PHONY: clean
clean:
	$(RM) $(OBJ) $(TARGET)

.PHONY: debug
debug: CFLAGS += -g
debug: clean all

.PHONY: check
check:all
	$(TESTSUIT)
