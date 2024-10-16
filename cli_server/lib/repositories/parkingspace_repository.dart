import 'package:cli_server/models/parking_space.dart';
import 'package:cli_server/repositories/repository.dart';

class ParkingSpaceRepository extends Repository<ParkingSpace> {
  ParkingSpaceRepository._privateConstructor();

  static final ParkingSpaceRepository _instance =
      ParkingSpaceRepository._privateConstructor();

  factory ParkingSpaceRepository() => _instance;
  static final List<ParkingSpace> _parkingSpaces = [];

  List<ParkingSpace> get allParkingSpaces => _parkingSpaces;

  void addParkingSpace(ParkingSpace parkingSpace) {
    _parkingSpaces.add(parkingSpace);
    add(parkingSpace);
  }

  void removeParkingSpace(ParkingSpace parkingSpace) {
    _parkingSpaces.remove(parkingSpace);
    delete(parkingSpace);
  }

  void updateParkingSpace(int index, ParkingSpace updatedParkingSpace) {
    _parkingSpaces[index].address = updatedParkingSpace.address;
    _parkingSpaces[index].pricePerHour = updatedParkingSpace.pricePerHour;
    update(index, updatedParkingSpace);
  }
}
