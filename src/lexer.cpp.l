%option c++
%option noyywrap nounput noinput

%{
    #include <ostream>
    #include <sstream>
    #include <fstream>
    #include <time.h>

    std::ostringstream oss;

    #define loop(n) for (int WE_CAN_ONLY_HOPE_TO_GOD_THAT_THE_NAME_OF_THIS_VARIABLE_DOES_NOT_CONFLICT_WITH_ANY_OTHER_VARIABLE = 1; WE_CAN_ONLY_HOPE_TO_GOD_THAT_THE_NAME_OF_THIS_VARIABLE_DOES_NOT_CONFLICT_WITH_ANY_OTHER_VARIABLE <= (n); WE_CAN_ONLY_HOPE_TO_GOD_THAT_THE_NAME_OF_THIS_VARIABLE_DOES_NOT_CONFLICT_WITH_ANY_OTHER_VARIABLE++)

    constexpr size_t table_size = 5;
    constexpr char* eol_replacing_table[table_size] = {" ", "  ", "\n" "\n  ", "\n    "};

    int randInt(const int, const int);
%}

D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			([Ee][+-]?{D}+)
P           ([Pp][+-]?{D}+)
FS			(f|F|l|L)
IS          ((u|U)|(u|U)?(l|L|ll|LL)|(l|L|ll|LL)(u|U))

WS          (" "|\t|\r|\n|\r\n)*


comment1    "/*"((\*+[^/*])|([^*]))*\**"*/"
comment2    \/\/.*\n
COMMENT     {comment1}|{comment2}

STRING      L?\"(\\.|[^\\"\n])*\"
CHAR        L?'\\.|[^\\'\n]'

IDENTIFIER  {L}({L}|{D})*

integer     0[xX]{H}+{IS}?|0[0-7]*{IS}?|[1-9]{D}*{IS}?
floating    {D}+{E}{FS}?{D}*"."{D}+{E}?{FS}?|{D}+"."{D}*{E}?{FS}?|0[xX]{H}+{P}{FS}?|0[xX]{H}*"."{H}+{P}?{FS}?|0[xX]{H}+"."{H}*{P}?{FS}?
CONSTANT    {integer}|{floating}


DIRECTIVE   {WS}?#.+?\n

SYMBOL      "..."|">>="|"<<="|"+="|"-="|"*="|"/="|"%="|"&="|"^="|"|="|">>"|"<<"|"++"|"--"|"->"|"&&"|"||"|"<="|">="|"=="|"!="|";"|("{"|"<%")|("}"|"%>")|","|":"|"="|"("|")"|("["|"<:")|("]"|":>")|"."|"&"|"!"|"~"|"-"|"+"|"*"|"/"|"%"|"<"|">"|"^"|"|"|"?"

%%

{COMMENT}       { oss << yytext; }
{STRING}        { oss << yytext; }
{CHAR}          { oss << yytext; }
{IDENTIFIER}    { oss << yytext; }
{CONSTANT}      { oss << yytext; }
{DIRECTIVE}     { oss << yytext; }
{SYMBOL}        { oss << yytext; }

{WS} {
    oss << " ";
    int r;
    while (1) {
        r = randInt(1, 100);
        if (0 < r && r <= 40) { // 40%
            break;
        }
        if (40 < r && r <= 94) { // 54%
            oss << ' ';
            continue;
        }
        if (94 < r && r <= 100) { // 6%
            oss << '\n';
            continue;
        }
    }
}

. { oss << yytext; }

%%


// min <= randInt(min, max) <= max
int randInt(const int min, const int max) {
    return min + rand() % (max - min + 1);
}


int main(int argc, const char* argv[]) {
    if (argc != 2) {
        std::cerr << "[Error] Usage: " << argv[0] << ' '
                  << "input-input_file" << std::endl;
        return 1;
    }

    const std::string filename = argv[1];

    std::ifstream input_file;
    input_file.open(filename);
    if (!input_file) {
        std::cerr << "[Error] No such file or directory: '" << filename << "'" << std::endl;
        return 1;
    }

    srand((unsigned)time(NULL));

    auto lexer = new yyFlexLexer();
    lexer->switch_streams(&input_file);
    lexer->yylex();

    std::ofstream output_file;
    output_file.open(filename);
    if (!output_file) {
        std::cerr << "[Error] No such file or directory: '" << filename << "'" << std::endl;
        return 1;
    }
    output_file << oss.str();
    output_file.close();

    return 0;
}
