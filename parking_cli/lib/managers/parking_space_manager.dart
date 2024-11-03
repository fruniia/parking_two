import 'package:parking_cli/repositories/parkingspace_repository.dart';
import 'package:parking_cli/utils/utils.dart';
import 'package:parking_cli_shared/parking_cli_shared.dart';

class ParkingSpaceManager {
  ParkingSpaceRepository parkingSpaceRepo = ParkingSpaceRepository();
  
Future<void> deleteParkingSpaces() async {
  var parkingSpaces = await showParkingSpaces();

  if (parkingSpaces.isNotEmpty) {
    var index = await getInput('index to delete');

    if (index != null && index >= 0 && index < parkingSpaces.length) {
      displayWarning('Do you really want to delete?');
      var str = getTextInput();
      if (str != null && str.toLowerCase() == 'y') {
        await parkingSpaceRepo.delete(parkingSpaces[index].id);
      }
    }
  } else {
    print('Nothing to delete');
  }
}

Future<void> updateParkingSpaces() async {
  var parkingSpaces = await showParkingSpaces();
  if (parkingSpaces.isNotEmpty) {
    var index = await getInput(
        'index of Parkingspaces (${parkingSpaces.length == 1 ? '0' : '0-${parkingSpaces.length - 1}'})');

    if (index != null && index >= 0 && index < parkingSpaces.length) {
      var parkingSpaceToUpdate = parkingSpaces[index];
      int? choice = await getInput(
          'what you would like to update? (1:Address 2:Price per Hour)');

      if (choice == 1) {
        displayInfo('Update address');
        var newAddress = setAddress();

        if (newAddress.isNotEmpty) {
          parkingSpaceToUpdate.address = newAddress;
          await parkingSpaceRepo.update(
              parkingSpaceToUpdate.id, parkingSpaceToUpdate);
        }
      } else if (choice == 2) {
        displayInfo('Update Price per Hour');
        var newPricePerHour = setPricePerHour();

        if (newPricePerHour > 0) {
          parkingSpaceToUpdate.pricePerHour = newPricePerHour;
          await parkingSpaceRepo.update(
              parkingSpaceToUpdate.id, parkingSpaceToUpdate);
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
  await parkingSpaceRepo.add(ps);
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

}
