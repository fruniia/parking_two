import 'package:parking_cli/repositories/parkingspace_repository.dart';
import 'package:parking_cli_shared/parking_cli_shared.dart';

import 'package:parking_cli/menus/menu.dart';
import 'package:parking_cli/utils/utils.dart';

Future<void> parkingSpaceMenu(String menuType) async {
   final subMenu = Menu(
      'You have choosen to handle ${menuType.toUpperCase()}. Please choose 1-5:',
      {
        1: 'Create new $menuType',
        2: 'Show all $menuType',
        3: 'Update $menuType',
        4: 'Remove $menuType',
        5: 'Back to main menu'
      });

  bool running = true;
  while (running) {
    subMenu.display();
    int? choice = getNumberInput();
    switch (choice) {
      case 1:
        await addParkingSpace();
        await showParkingSpaces();
        break;
      case 2:
        await showParkingSpaces();
        break;
      case 3:
        await updateParkingSpaces();
        break;
      case 4:
        await deleteParkingSpaces();
        break;
      case 5:
        clearScreen();
        return;
      default:
        clearScreen();
        displayWarning('Please choose a valid number');
        break;
    }
  }
}

Future<void> deleteParkingSpaces() async {
  var parkingSpaces = await showParkingSpaces();

  if (parkingSpaces.isNotEmpty) {
    displayInfo('Please enter index to delete: ');
    var index = getNumberInput();

    if (index != null && index >= 0 && index < parkingSpaces.length) {
      displayWarning('Do you really want to delete?');
      var str = getTextInput();
      if (str != null && str.toLowerCase() == 'y') {
        ParkingSpaceRepository().delete(parkingSpaces[index].id);
      }
    }
  } else {
    print('Nothing to delete');
  }
}

Future<void> updateParkingSpaces() async {
  var parkingSpaces = await showParkingSpaces();
  if (parkingSpaces.isNotEmpty) {
    displayInfo(
        'Please choose index of Parkingspaces (${parkingSpaces.length == 1 ? '0' : '0-${parkingSpaces.length - 1}'}): ');
    var index = getNumberInput();
    if (index != null) {
      var parkingSpaceToUpdate = parkingSpaces[index];
      print('What would you like to update? (1:Address 2:Price per Hour)');
      int? choice = getNumberInput();

      if (choice == 1) {
        displayInfo('Update address');
        var newAddress = setAddress();

        if (newAddress.isNotEmpty) {
          parkingSpaceToUpdate.address = newAddress;
        }
      } else if (choice == 2) {
        displayInfo('Update Price per Hour');
        var newPricePerHour = setPricePerHour();

        if (newPricePerHour > 0) {
          parkingSpaceToUpdate.pricePerHour = newPricePerHour;
        }
      } else {
        displayWarning('Invalid choice');
      }
    }
  } else {
    print('Nothing to update');
  }
}

String setAddress() {
  displayInfo('Please enter address');
  var address = getTextInput();
  return address ?? '';
}

double setPricePerHour() {
  displayInfo('Please enter price per hour');
  var price = getDoubleInput();
  return price ?? 0.0;
}

Future<void> addParkingSpace() async {
  var address = setAddress();
  var price = setPricePerHour();
  ParkingSpace ps =
      ParkingSpace.withUUID(address: address, pricePerHour: price);
  await ParkingSpaceRepository().add(ps);
}

Future<List<ParkingSpace>> showParkingSpaces() async {
  List<ParkingSpace> parkingSpaces = await ParkingSpaceRepository().getAll();
  if (parkingSpaces.isNotEmpty) {
    for (int i = 0; i < parkingSpaces.length; i++) {
      var parkingSpace = parkingSpaces[i];
      print(
          'Index $i Address: ${parkingSpace.address.padRight(10)} Price per hour (SEK): ${parkingSpace.pricePerHour.toString().padLeft(5)}');
    }
  } else {
    print('No parkingspaces');
  }
  return parkingSpaces;
}
