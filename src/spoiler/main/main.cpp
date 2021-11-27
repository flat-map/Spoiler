#include <iostream>
#include <fstream>
#include <sstream>
#include <time.h>
#include <spoiler/driver/driver.hpp>


int main(int argc, char **argv) {
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
    yy::Driver driver;
    std::ostringstream result;
    driver.parse(input_file, result);

    std::ofstream output_file;
    output_file.open(filename);
    if (!output_file) {
        std::cerr << "[Error] No such file or directory: '" << filename << "'" << std::endl;
        return 1;
    }
    output_file << result.str();
    output_file.close();

    return 0;
}