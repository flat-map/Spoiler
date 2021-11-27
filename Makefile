src = src/spoiler
CXXFLAGS = -g -Wall -Wextra -std=c++11 -O4 -I src

.PHONY: all clean run

all: clean bin/spoiler

clean:
	@printf "\e[33m[%s]\e[0m\n" "clean"
	@rm -f bin/*
	@rm -f $(src)/lexer/lexer.gen.* $(src)/parser/parser.tab.* $(src)/parser/location.hh $(src)/parser/parser.output

run: bin/spoiler example/input.c
	@printf "\e[33m[%s]\e[0m\n" "run"
	@./bin/spoiler example/input.c


bin/spoiler: $(src)/lexer/lexer.gen.cpp $(src)/parser/parser.tab.cc $(src)/driver/driver.cpp $(src)/main/main.cpp
	@printf "\e[33m[%s]\e[0m\n" "$^ -> $@"
	@g++ $(CXXFLAGS) -o $@ $^

$(src)/parser/parser.tab.cc: $(src)/parser/parser.yy
	@printf "\e[33m[%s]\e[0m\n" "$^ -> $@"
	@bison -v -o $@ $^

$(src)/lexer/lexer.gen.cpp: $(src)/lexer/lexer.ll
	@printf "\e[33m[%s]\e[0m\n" "$^ -> $@"
	@flex --outfile=$@ $^

