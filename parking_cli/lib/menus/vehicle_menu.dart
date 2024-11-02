import 'dart:io';

import 'package:cli_server/handlers/vehicle_handler.dart';
import 'package:parking_cli/repositories/person_repository.dart';
import 'package:parking_cli/repositories/vehicle_repository.dart';
import 'package:parking_cli_shared/parking_cli_shared.dart';

import 'package:parking_cli/menus/menu.dart';
import 'package:parking_cli/utils/utils.dart';

PersonRepository personRepos = PersonRepository();
VehicleRepository vehicleRepository = VehicleRepository();

Future<void> vehicleMenu(String menuType) async {
  clearScreen();
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
        await addVehicle();
        break;
      case 2:
        await showVehicles();
        break;
      case 3:
        await updateVehicle();
        break;
      case 4:
        await deleteVehicle();
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

Future<void> deleteVehicle() async {
  var vehicles = await showVehicles();
  if (vehicles.isNotEmpty) {
    displayInfo('Please enter index to delete: ');
    var index = getNumberInput();

    if (index != null && index >= 0 && index < vehicles.length) {
      displayWarning('Do you really want to delete?');
      var str = getTextInput();

      if (str != null && str.toLowerCase() == 'y') {
       await vehicleRepository.delete(vehicles[index].id);
      }
    }
  } else {
    displayInfo('Nothing to delete');
  }
}

Future<void> updateVehicle() async {
  var vehicles = await showVehicles();
  if (vehicles.isNotEmpty) {
    displayInfo(
        'Please choose index of Vehicle (${vehicles.length == 1 ? '0' : '0-${vehicles.length - 1}'})');
    var index = getNumberInput();

    if (index != null) {
      var vehicleToUpdate = vehicles[index];
      print(
          'What would you like to update? (1:Licenseplate 2:VehicleType 3:Owner)');
      int? choice = getNumberInput();

      if (choice == 1) {
        displayInfo('Update licenseplate');
        var newLicensePlate = setLicensePlate();

        if (newLicensePlate.isNotEmpty) {
          vehicleToUpdate.licensePlate = newLicensePlate;
        }
      } else if (choice == 2) {
        displayInfo('Update VehicleType');
        var newVehicleType = chooseVehicleType();

        if (newVehicleType != null) {
          vehicleToUpdate.vehicleType = newVehicleType;
        }
      } else if (choice == 3) {
        displayInfo('Update Owner');
        var persons = await getPersons();
        Person updatedOwner;

        if (persons.isNotEmpty) {
          for (int i = 0; i < persons.length; i++) {
            print('$i ${persons[i].name}');
          }

          displayInfo('Please choose index:');
          var index = getNumberInput();

          if (index != null) {
            updatedOwner = persons[index];
            vehicleToUpdate.owner = updatedOwner;
          }
        }
      } else {
        displayWarning('Invalid choice');
      }
      await vehicleRepo.update(vehicleToUpdate.id, vehicleToUpdate);
    }
  } else {
    print('Nothing to update');
  }
}

Future<List<Person>> getPersons() async {
  return await personRepos.getAll();
}

Future<void> addVehicle() async {
  List<Person> persons = await getPersons();
  Person person;

  if (persons.isNotEmpty) {
    for (int i = 0; i < persons.length; i++) {
      print('$i ${persons[i].name}');
    }

    displayInfo('Please choose index of owner:');
    var index = getNumberInput();

    if (index != null) {
      person = persons[index];
      var licensePlate = setLicensePlate();
      var vehicleType = chooseVehicleType();

      if (vehicleType != null) {
        Vehicle v = Vehicle.withUUID(
            licensePlate: licensePlate,
            owner: person,
            vehicleType: vehicleType);

        await vehicleRepository.add(v);
      }
    }
  } else {
    displayWarning('You need to register before you add your vehicle.');
  }
}

VehicleType? chooseVehicleType() {
  displayInfo('Please choose a vehicletype');
  for (var type in VehicleType.values) {
    print('${type.index}: ${type.name}');
  }

  var isValid = false;
  while (!isValid) {
    displayInfo('Please enter number for the type:');
    var input = getNumberInput();

    if (input != null && input >= 0 && input < VehicleType.values.length) {
      displayInfo('Your choice: ${VehicleType.values[input].name}');
      isValid = true;
    } else {
      displayWarning('Not a valid choice, please enter a valid number');
    }

    if (isValid && input != null) {
      return VehicleType.values[input];
    }
  }
  return null;
}

Future<List<Vehicle>> showVehicles() async {
  List<Vehicle> vehicles = await vehicleRepository.getAll();
  if (vehicles.isNotEmpty) {
    for (int index = 0; index < vehicles.length; index++) {
      var vehicle = vehicles[index];
      print(
          'Index $index: Type: ${vehicle.vehicleType.name} LicensePlate: ${vehicle.licensePlate} Owner: ${vehicle.owner.name}');
    }
  } else {
    print('No vehicles registered');
  }
  return vehicles;
}

String setLicensePlate() {
  bool isValid = false;
  String? licensePlate;

  while (!isValid) {
    displayInfo('Please enter licenseplate (ABC123 / ABC12A):');
    licensePlate = stdin.readLineSync();

    if (licensePlate != null && licensePlate != '') {
      validLicensePlate(licensePlate)
          ? displaySuccess('Valid licenseplate')
          : displayWarning('Invalid licenseplate');
      isValid = validLicensePlate(licensePlate);
    }
  }
  return licensePlate ?? '';
}

bool validLicensePlate(String str) {
  var regExp = RegExp(r'([A-Z,a-z]{3}[0-9]{2}[A-Z,a-z,0-9]{1})');
  return regExp.hasMatch(str);
}
