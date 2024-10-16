import 'package:parking_cli/models/parking.dart';
import 'package:parking_cli/repositories/repository.dart';

class ParkingRepository extends Repository<Parking> {
  ParkingRepository._privateConstructor();

  static final ParkingRepository _instance =
      ParkingRepository._privateConstructor();

  factory ParkingRepository() => _instance;
  static final List<Parking> _parkings = [];

  List<Parking> get allParkings => _parkings;

  void addParking(Parking parking) {
    _parkings.add(parking);
    add(parking);
  }

  void removeParking(Parking parking) {
    _parkings.remove(parking);
    delete(parking);
  }

  void updateParking(int index, Parking updatedParking) {
    _parkings[index].vehicle = updatedParking.vehicle;
    _parkings[index].parkingSpace = updatedParking.parkingSpace;
    _parkings[index].start = updatedParking.start;
    _parkings[index].stop = updatedParking.stop;
    update(index, updatedParking);
  }
}
