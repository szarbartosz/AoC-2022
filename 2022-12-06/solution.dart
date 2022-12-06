import 'dart:io';

solution_pt_1() async {
  String input = await File('input.txt').readAsString();

  for (int i = 0; i <= input.length - 4; i++) {
    if (input.substring(i, i + 4).split('').toSet().length == 4) {
      return i + 4;
    }
  }
}

solution_pt_2() async {
  String input = await File('input.txt').readAsString();

  for (int i = 0; i <= input.length - 14; i++) {
    if (input.substring(i, i + 14).split('').toSet().length == 14) {
      return i + 14;
    }
  }
}

main() async {
  print(await solution_pt_1());
  print(await solution_pt_2());
}
