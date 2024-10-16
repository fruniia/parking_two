import 'package:parking_cli/utils/utils.dart';

class Menu {
  final Map<int, String> options;
  final String title;
  

  Menu(this.title, this.options);

  void display() {
    displaySuccess(title);
    options.forEach((key, value) {
      displayInfo("$key: $value");
    });
  }

  int? getUserChoice() {
    int? choice = getNumberInput();
    if (choice != null && options.containsKey(choice)) {
      return choice;
    }
    return null;
  }
}
