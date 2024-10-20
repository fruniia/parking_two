import 'package:parking_cli/models/parking.dart';
import 'package:parking_cli/repositories/repository.dart';

class ParkingRepository extends Repository<Parking> {
  ParkingRepository._privateConstructor();

  static final ParkingRepository _instance =
      ParkingRepository._privateConstructor();

  factory ParkingRepository() => _instance;
}
