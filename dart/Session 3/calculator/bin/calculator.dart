import 'dart:io';

void main() {
  while (true) {
    // print('Wanna Exit! Enter y');
    String isExit = userInput(label: 'Wanna Exit! Enter y');
    if (isExit == 'y') {
      break;
    }
    // print('Enter First Number');
    double fNum = userInput(isNum: true, label: 'Enter First Number');
    // print('Enter Operation');
    String op = userInput(label: 'Enter Operation');
    // print('Enter Second Number');
    double sNum = userInput(isNum: true, label: 'Enter Second Number');
    double res;

    switch (op) {
      case '+':
        res = fNum + sNum;
        break;
      case '-':
        res = fNum - sNum;
        break;
      case '*':
        res = fNum * sNum;
        break;
      case '/':
        res = fNum / sNum;
        break;
      default:
        res = 0;
        print('Enter Valid Operation');
    }

    print('Result: $res');
  }
}

dynamic userInput({required String label, bool isNum = false}) {
  print(label);
  return isNum ? double.parse(stdin.readLineSync()!) : stdin.readLineSync()!;
  // if (isNum) {
  //   return double.parse(stdin.readLineSync()!);
  // } else {
  //   return stdin.readLineSync()!;
  // }
}
