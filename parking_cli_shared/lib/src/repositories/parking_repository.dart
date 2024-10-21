import 'package:parking_cli_shared/parking_cli_shared.dart';

class ParkingRepository extends Repository<Parking> {
  ParkingRepository._privateConstructor();

  static final ParkingRepository _instance =
      ParkingRepository._privateConstructor();

  factory ParkingRepository() => _instance;
}
