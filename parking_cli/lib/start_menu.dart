import 'dart:io';
import 'package:parking_cli/menu.dart';
import 'package:parking_cli/parking_menu.dart';
import 'package:parking_cli/parking_space_menu.dart';
import 'package:parking_cli/person_menu.dart';
import 'package:parking_cli/utils/utils.dart';
import 'package:parking_cli/vehicle_menu.dart';

void startMenu() {
  final startMenu = Menu(
      'Welcome to the parking app \nWhat do you want to handle? (Choose: 1-5)',
      {
        1: 'Persons',
        2: 'Vehicles',
        3: 'Parkingspaces',
        4: 'Parkings',
        5: 'Quit'
      });

  bool running = true;

  while (running) {
    startMenu.display();
    int? choice = startMenu.getUserChoice();
    switch (choice) {
      case 1:
        personMenu('persons');
        break;
      case 2:
        vehicleMenu('vehicles');
        break;
      case 3:
        parkingSpaceMenu('parkingspaces');
        break;
      case 4:
        parkingMenu('parkings');
        break;
      case 5:
        running = quit();
      default:
        clearScreen();
        displayWarning('Please choose a valid number');
        break;
    }
  }
}

bool quit() {
  displayWarning('Do you want to quit? (Y/N)');
  var input = stdin.readLineSync();
  if (input != null && input.toLowerCase() == 'y') {
    clearScreen();
    displayInfo('Thank you for using our service.');
    exit(0);
  } else {
    clearScreen();
    return true;
  }
}
