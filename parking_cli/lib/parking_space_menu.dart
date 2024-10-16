import 'package:parking_cli/models/parking_space.dart';
import 'package:parking_cli/repositories/parkingspace_repository.dart';

import 'package:parking_cli/menu.dart';
import 'package:parking_cli/utils/utils.dart';

void parkingSpaceMenu(String menuType) {
  final parkingSpaceRepo = ParkingSpaceRepository();
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
        addParkingSpace(parkingSpaceRepo);
        showParkingSpaces(parkingSpaceRepo);
        break;
      case 2:
        showParkingSpaces(parkingSpaceRepo);
        break;
      case 3:
        updateParkingSpaces(parkingSpaceRepo);
        break;
      case 4:
        deleteParkingSpaces(parkingSpaceRepo);
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

void deleteParkingSpaces(ParkingSpaceRepository parkingSpaceRepo) {
  var parkingSpaces = showParkingSpaces(parkingSpaceRepo);

  if (parkingSpaces.isNotEmpty) {
    displayInfo('Please enter index to delete: ');
    var index = getNumberInput();

    if (index != null && index >= 0 && index < parkingSpaces.length) {
      var parkingSpace = parkingSpaces[index];
      displayWarning('Do you really want to delete?');
      var str = getTextInput();
      if (str != null && str.toLowerCase() == 'y') {
        parkingSpaceRepo.removeParkingSpace(parkingSpace);
      }
    }
  } else {
    print('Nothing to delete');
  }
}

void updateParkingSpaces(ParkingSpaceRepository parkingSpaceRepo) {
  var parkingSpaces = showParkingSpaces(parkingSpaceRepo);
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

void addParkingSpace(ParkingSpaceRepository parkingSpaceRepo) {
  var address = setAddress();
  var price = setPricePerHour();
  ParkingSpace ps =
      ParkingSpace.withUUID(address: address, pricePerHour: price);
  parkingSpaceRepo.addParkingSpace(ps);
}

List<ParkingSpace> showParkingSpaces(ParkingSpaceRepository parkingRepo) {
  List<ParkingSpace> parkingSpaces = parkingRepo.allParkingSpaces;
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
