CXXFLAGS = -Wall -Wextra -std=c++11 -O4

.PHONY: all clean run

all: clean bin/unformatter

clean:
	@echo "\e[33m[clean]\e[0m"
	@rm -f bin/*
	@rm -f src/lexer.cpp

run: bin/unformatter example/input.c
	@echo "\e[33m[run]\e[0m"
	@./bin/unformatter example/input.c

bin/unformatter: src/lexer.cpp
	@echo "\e[33m[$^ -> $@]\e[0m"
	@g++ -g $(CXXFLAGS) -o $@ $^

src/lexer.cpp: src/lexer.cpp.l
	@echo "\e[33m[$^ -> $@]\e[0m"
	@flex -o $@ $^

