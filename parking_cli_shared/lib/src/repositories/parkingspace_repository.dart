import 'package:parking_cli_shared/parking_cli_shared.dart';

class ParkingSpaceRepository extends Repository<ParkingSpace> {
  ParkingSpaceRepository._privateConstructor();

  static final ParkingSpaceRepository _instance =
      ParkingSpaceRepository._privateConstructor();

  factory ParkingSpaceRepository() => _instance;
}
