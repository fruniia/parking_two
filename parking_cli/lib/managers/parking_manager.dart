import 'package:parking_cli/repositories/parking_repository.dart';
import 'package:parking_cli/repositories/parkingspace_repository.dart';
import 'package:parking_cli/repositories/person_repository.dart';
import 'package:parking_cli/repositories/vehicle_repository.dart';
import 'package:parking_cli/utils/utils.dart';
import 'package:parking_cli_shared/parking_cli_shared.dart';

class ParkingManager {
  PersonRepository personRepos = PersonRepository();
  VehicleRepository vehicleRepos = VehicleRepository();
  ParkingSpaceRepository parkingSpaceRepos = ParkingSpaceRepository();
  ParkingRepository parkingRepos = ParkingRepository();

  Future<List<Vehicle>> _getVehicles() async {
    return await vehicleRepos.getAll();
  }

  Future<List<ParkingSpace>> _getParkingSpaces() async {
    return await parkingSpaceRepos.getAll();
  }

  Future<void> deleteParking() async {
    var parkings = await showParkings();
    if (parkings.isNotEmpty) {
      var index = await getInput('index');

      if (index != null && index >= 0 && index < parkings.length) {
        displayWarning('Do you really want to delete');
        var str = getTextInput();

        if (str != null && str.toLowerCase() == 'y') {
          await parkingRepos.delete(parkings[index].id);
        }
      }
    } else {
      displayInfo('Nothing to delete');
    }
  }

  Future<void> updateParking() async {
    var parkings = await showParkings();
    if (parkings.isNotEmpty) {
      var index = await getInput(
          'index of Parking ${parkings.length == 1 ? '0' : '0-${parkings.length - 1}'}');

      if (index != null && index <= 0 && index < parkings.length) {
        var parkingToUpdate = parkings[index];

        var choice = await getInput(
            'what you would like to update?\n(1: Vehicle 2: ParkingSpace 3: StartTime 4: StopTime)');

        if (choice == 1) {
          displayInfo('Update vehicle');
          var vehicles = await _getVehicles();
          Vehicle vehicleUpdate;

          if (vehicles.isNotEmpty) {
            for (int i = 0; i < vehicles.length; i++) {
              print('$i: ${vehicles[i].licensePlate}');
            }

            var num = await getInput('index');

            if (num != null) {
              vehicleUpdate = vehicles[num];
              parkingToUpdate.vehicle = vehicleUpdate;
            }
          }
        } else if (choice == 2) {
          displayInfo('Update parkingspace');
          var parkingSpaces = await _getParkingSpaces();
          ParkingSpace parkingSpaceUpdate;

          if (parkingSpaces.isNotEmpty) {
            for (int i = 0; i < parkingSpaces.length; i++) {
              print('$i: ${parkingSpaces[i].address}');
            }

            var num = await getInput('index');

            if (num != null) {
              parkingSpaceUpdate = parkingSpaces[num];
              parkingToUpdate.parkingSpace = parkingSpaceUpdate;
            }
          }
        } else if (choice == 3) {
          displayInfo('Update starttime');
          for (int i = 0; i < parkings.length; i++) {
            print(
                '$i ${parkings[i].start.year}-${parkings[i].start.month}-${parkings[i].start.day} ${parkings[i].start.hour.toString().padLeft(2, '0')}:${parkings[i].start.minute.toString().padLeft(2, '0')}');
          }
          var index = await getInput('index');

          if (index != null && index < parkings.length) {
            var year = await getInput('year (YYYY)');
            var month = await getInput('month (MM)');
            var day = await getInput('day (DD)');
            var hour = await getInput('hour (HH))');
            var minute = await getInput('minute (mm))');
            year ??= DateTime.now().year;
            month ??= DateTime.now().month;
            day ??= DateTime.now().day;
            hour ??= DateTime.now().hour;
            minute ??= DateTime.now().minute;
            parkingToUpdate
                .updateStart(DateTime(year, month, day, hour, minute));
          }
        } else if (choice == 4) {
          displayInfo('Update stopTime');
          for (int i = 0; i < parkings.length; i++) {
            print(
                '$i ${parkings[i].start.year}-${parkings[i].start.month}-${parkings[i].start.day} ${parkings[i].start.hour.toString().padLeft(2, '0')}:${parkings[i].start.minute.toString().padLeft(2, '0')}');
          }

          var index = await getInput('index');
          if (index != null && index < parkings.length) {
            var year = await getInput('year (YYYY)');
            var month = await getInput('month (MM)');
            var day = await getInput('day (DD)');
            var hour = await getInput('hour (HH))');
            var minute = await getInput('minute (mm))');
            year ??= DateTime.now().year;
            month ??= DateTime.now().month;
            day ??= DateTime.now().day;
            hour ??= DateTime.now().hour;
            minute ??= DateTime.now().minute;
            parkingToUpdate
                .updateStop(DateTime(year, month, day, hour, minute));
          }
        } else {
          displayWarning('Invalid choice');
        }
      }
    }
  }

  Future<void> addParking() async {
    List<Vehicle> vehicles = await _getVehicles();
    List<ParkingSpace> parkingSpaces = await _getParkingSpaces();
    Vehicle? vehicle;
    ParkingSpace? parkingSpace;
    if (vehicles.isNotEmpty && parkingSpaces.isNotEmpty) {
      for (int i = 0; i < vehicles.length; i++) {
        print('$i ${vehicles[i].licensePlate}');
      }
      var index = await getInput('index of vehicle');

      if (index != null) {
        vehicle = vehicles[index];
      }
      for (int j = 0; j < parkingSpaces.length; j++) {
        print('$j ${parkingSpaces[j].address}');
      }
      var index2 = await getInput('index of parkingspace');
      if (index2 != null) {
        parkingSpace = parkingSpaces[index2];
      }

      if (vehicle != null && parkingSpace != null) {
        Parking p = Parking.withUUID(
          vehicle: vehicle,
          parkingSpace: parkingSpace,
        );
        await parkingRepos.add(p);
        displaySuccess('Parking added successfully');
      } else {
        displayWarning('Vehicle or parking space selection is invalid');
      }
    } else {
      if (vehicles.isEmpty) {
        displayWarning(
            'You need to register a vehicle before you add a parking');
      }
      if (parkingSpaces.isEmpty) {
        displayWarning(
            'You need to register a parkingspace before you add a parking');
      }
    }
  }

  Future<List<Parking>> showParkings() async {
    List<Parking> parkings = await parkingRepos.getAll();
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
}
