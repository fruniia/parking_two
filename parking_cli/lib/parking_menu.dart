import 'package:parking_cli/models/parking.dart';
import 'package:parking_cli/models/parking_space.dart';
import 'package:parking_cli/models/vehicle.dart';
import 'package:parking_cli/repositories/parking_repository.dart';

import 'package:parking_cli/menu.dart';
import 'package:parking_cli/repositories/parkingspace_repository.dart';
import 'package:parking_cli/repositories/vehicle_repository.dart';
import 'package:parking_cli/utils/utils.dart';

void parkingMenu(String menuType) {
  final parkingRepo = ParkingRepository();
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
        addParking(parkingRepo);
        break;
      case 2:
        showParkings(parkingRepo);
        break;
      case 3:
        updateParking(parkingRepo);
        break;
      case 4:
        deleteParking(parkingRepo);
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

List<Vehicle> getVehicles() {
  return VehicleRepository().allVehicles;
}

List<ParkingSpace> getParkingSpaces() {
  return ParkingSpaceRepository().allParkingSpaces;
}

void deleteParking(ParkingRepository parkingRepo) {
  var parkings = showParkings(parkingRepo);
  if (parkings.isNotEmpty) {
    displayInfo('Please enter index to delete:');
    var index = getNumberInput();

    if (index != null && index >= 0 && index < parkings.length) {
      var parking = parkings[index];
      displayWarning('Do you really want to delete');
      var str = getTextInput();

      if (str != null && str.toLowerCase() == 'y') {
        parkingRepo.removeParking(parking);
      }
    }
  } else {
    displayInfo('Nothing to delete');
  }
}

void updateParking(ParkingRepository parkingRepo) {
  var parkings = showParkings(parkingRepo);
  if (parkings.isNotEmpty) {
    displayInfo(
        'Please choose index of Parking ${parkings.length == 1 ? '0' : '0-${parkings.length - 1}'}');

    var index = getNumberInput();

    if (index != null) {
      var parkingToUpdate = parkings[index];
      print(
          'What would you like to update? (1: Vehicle 2: ParkingSpace 3: StartTime 4:StopTime)');

      int? choice = getNumberInput();
      if (choice == 1) {
        displayInfo('Update vehicle');
        var vehicles = getVehicles();
        Vehicle vehicleUpdate;

        if (vehicles.isNotEmpty) {
          for (int i = 0; i < vehicles.length; i++) {
            print('$i: ${vehicles[i].licensePlate}');
          }

          displayInfo('Please choose index:');
          var index = getNumberInput();

          if (index != null) {
            vehicleUpdate = vehicles[index];
            parkingToUpdate.vehicle = vehicleUpdate;
          }
        }
      } else if (choice == 2) {
        displayInfo('Update parkingspace');
        var parkingSpaces = getParkingSpaces();
        ParkingSpace parkingSpaceUpdate;

        if (parkingSpaces.isNotEmpty) {
          for (int i = 0; i < parkingSpaces.length; i++) {
            print('$i: ${parkingSpaces[i].address}');
          }

          displayInfo('Please choose index');
          var index = getNumberInput();

          if (index != null) {
            parkingSpaceUpdate = parkingSpaces[index];
            parkingToUpdate.parkingSpace = parkingSpaceUpdate;
          }
        }
      } else if (choice == 3) {
        displayInfo('Update starttime');
        for (int i = 0; i < parkings.length; i++) {
          print(
              '$i ${parkings[i].start.year}-${parkings[i].start.month}-${parkings[i].start.day} ${parkings[i].start.hour.toString().padLeft(2, '0')}:${parkings[i].start.minute.toString().padLeft(2, '0')}');
        }

        displayInfo('Please choose index');
        var index = getNumberInput();
        if (index != null && index < parkings.length) {
          displayInfo('Please enter year (YYYY)');
          int? year = getNumberInput();
          displayInfo('Please enter month (MM)');
          var month = getNumberInput();
          displayInfo('Please enter day (DD)');
          var day = getNumberInput();
          displayInfo('Please enter hour (HH))');
          var hour = getNumberInput();
          displayInfo('Please enter minute (mm))');
          var minute = getNumberInput();
          year ??= DateTime.now().year;
          month ??= DateTime.now().month;
          day ??= DateTime.now().day;
          hour ??= DateTime.now().hour;
          minute ??= DateTime.now().minute;
          parkingToUpdate.updateStart(DateTime(year, month, day, hour, minute));
        }
      } else if(choice == 4){
                displayInfo('Update stopTime');
        for (int i = 0; i < parkings.length; i++) {
          print(
              '$i ${parkings[i].start.year}-${parkings[i].start.month}-${parkings[i].start.day} ${parkings[i].start.hour.toString().padLeft(2, '0')}:${parkings[i].start.minute.toString().padLeft(2, '0')}');
        }

        displayInfo('Please choose index');
        var index = getNumberInput();
        if (index != null && index < parkings.length) {
          displayInfo('Please enter year (YYYY)');
          int? year = getNumberInput();
          displayInfo('Please enter month (MM)');
          var month = getNumberInput();
          displayInfo('Please enter day (DD)');
          var day = getNumberInput();
          displayInfo('Please enter hour (HH))');
          var hour = getNumberInput();
          displayInfo('Please enter minute (mm))');
          var minute = getNumberInput();

          year ??= DateTime.now().year;
          month ??= DateTime.now().month;
          day ??= DateTime.now().day;
          hour ??= DateTime.now().hour;
          minute ??= DateTime.now().minute;
          parkingToUpdate.updateStop(DateTime(year, month, day, hour, minute));
        }

      }else {
        displayWarning('Invalid choice');
      }
    }
  }
}

int? updateHour() {
  var year = getNumberInput();
  return year;
}

void addParking(ParkingRepository parkingRepo) {
  List<Vehicle> vehicles = getVehicles();
  List<ParkingSpace> parkingSpaces = getParkingSpaces();
  Vehicle? vehicle;
  ParkingSpace? parkingSpace;
  if (vehicles.isNotEmpty && parkingSpaces.isNotEmpty) {
    for (int i = 0; i < vehicles.length; i++) {
      print('$i ${vehicles[i].licensePlate}');
    }
    displayInfo('Please choose index of vehicle');
    var index = getNumberInput();

    if (index != null) {
      vehicle = vehicles[index];
    }
    for (int j = 0; j < parkingSpaces.length; j++) {
      print('$j ${parkingSpaces[j].address}');
    }
    displayInfo('Please choose index of parkingspace');
    var index2 = getNumberInput();
    if (index2 != null) {
      parkingSpace = parkingSpaces[index2];
    }

    if (vehicle != null && parkingSpace != null) {
      Parking p = Parking.withUUID(
        vehicle: vehicle,
        parkingSpace: parkingSpace,
      );
      parkingRepo.addParking(p);
      displaySuccess('Parking added successfully');
    } else {
      displayWarning('Vehicle or parking space selection is invalid');
    }
  } else {
    if (vehicles.isEmpty) {
      displayWarning('You need to register a vehicle before you add a parking');
    }
    if (parkingSpaces.isEmpty) {
      displayWarning(
          'You need to register a parkingspace before you add a parking');
    }
  }
}

List<Parking> showParkings(ParkingRepository parkingRepo) {
  List<Parking> parkings = parkingRepo.allParkings;
  if (parkings.isNotEmpty) {
    for (int i = 0; i < parkings.length; i++) {
      var parking = parkings[i];
      //Start shows HH:MM and Stop shows HH:MM
      print(
          'Index $i: Vehicle: ${parking.vehicle.licensePlate} ParkingSpace: ${parking.parkingSpace.address} Start: ${parking.start.hour.toString().padLeft(2, '0')}:${parking.start.minute.toString().padLeft(2, '0')} Stop:${parking.stop == null ? 'ongoing' : '${parking.stop?.hour.toString().padLeft(2, '0')}:${parking.stop?.minute.toString().padLeft(2, '0')}'}');
    }
  } else {
    print('No parkings registered');
  }
  return parkings;
}
