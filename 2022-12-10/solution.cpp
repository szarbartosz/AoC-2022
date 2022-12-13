#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;

using std::string;
using std::vector;

const int SCREEN_WIDTH = 40;
const int SCREEN_HEIGHT = 6;

std::vector<std::string> split(const std::string& str, const char delimiter) {
  std::vector<std::string> result;

  size_t pos = 0;
  while (pos < str.length()) {
    size_t next_pos = str.find(delimiter, pos);
    if (next_pos == std::string::npos) {
      result.push_back(str.substr(pos));
      break;
    } else {
      result.push_back(str.substr(pos, next_pos - pos));
      pos = next_pos + 1;
    }
  }

  return result;
}

int solution_pt_1() {
  std::ifstream inputFile("input.txt");
  std::vector<std::string> lines;

  std::string line;
  while (std::getline(inputFile, line)) {
    lines.push_back(line);
  }

  int X = 1;
  int cycle = 0;
  std::vector<int> result;

  for (const auto& line : lines) {
    std::vector<std::string> instruction = split(line, ' ');
    if (instruction[0] == "noop") {
      cycle += 1;
      if ((cycle - 20) % 40 == 0) {
        result.push_back(X * cycle);
      }
    } else {
      cycle += 1;

      if ((cycle - 20) % 40 == 0) {
        result.push_back(X * cycle);
      }

      cycle += 1;

      if ((cycle - 20) % 40 == 0) {
        result.push_back(X * cycle);
      }

      X += std::stoi(instruction[1]);
    }
  }

  int sum = 0;
  for (const auto& n : result) {
    sum += n;
  }
  return sum;
}

void solution_pt_2() {
  std::ifstream inputFile("input.txt");
  std::vector<std::string> lines;
  std::string line;

  while (std::getline(inputFile, line)) {
    lines.push_back(line);
  }

  int X = 1;
  int cycle = 0;
  std::vector<std::vector<char>> screen(6, std::vector<char>(40, '.'));
  int currentLine = 0;

  for (const auto& l : lines) {
    std::vector<std::string> instruction = split(l, ' ');

    if (instruction[0] == "noop") {
      if (abs(cycle % 40 - X) <= 1){
          screen[currentLine][cycle % 40] = '#';
      }
      cycle += 1;

      if (cycle % 40 == 0) {
          currentLine += 1;
      }
    }
    else {
      if (abs(cycle % 40 - X) <= 1){
        screen[currentLine][cycle % 40] = '#';
      }
      cycle += 1;

      if (cycle % 40 == 0){
        currentLine += 1;
      }

      if (abs(cycle % 40 - X) <= 1) {
        screen[currentLine][cycle % 40] = '#';
      }
      cycle += 1;

      if (cycle % 40 == 0) {
        currentLine += 1;
      }

      X += std::stoi(instruction[1]);
    }
  }

  for (int i = 0; i < SCREEN_HEIGHT; i++) {
    for (int j = 0; j < SCREEN_WIDTH; j++) {
      cout << screen[i][j];  
    } 
    cout << endl;
  }
}


int main() {
  cout << solution_pt_1() << endl;
  solution_pt_2();
  return 0;
}
