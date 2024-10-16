import 'dart:io';

void displayWarning(String text) {
  print('\x1B[93m$text\x1B[0m');
}

void displayInfo(String text) {
  stdout.writeln('\x1B[94m$text\x1B[0m');
}

void displaySuccess(String text) {
  stdout.writeln('\x1B[92m$text\x1B[0m');
}

void clearScreen() {
  stdout.writeln('\x1B[2J\x1B[0;0H');
}

int? getNumberInput() {
  var input = stdin.readLineSync();
  return int.tryParse(input ?? '');
}

double? getDoubleInput() {
  var input = stdin.readLineSync();
  return double.tryParse(input ?? '');
}

String? getTextInput() {
  var input = stdin.readLineSync();
  return input ?? '';
}
