import 'dart:io';

void main() {
  print('Enter Operation');
  String op = stdin.readLineSync()!;

  switch (op) {
    case '+':
      print('Add');
      break;
    case '-':
      print('Sub');
      break;
    case '*':
      print('Multi');
      break;
    default:
      print('Div');
  }
}
