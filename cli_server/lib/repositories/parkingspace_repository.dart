import 'package:cli_server/models/parking_space.dart';
import 'package:cli_server/repositories/repository.dart';

class ParkingSpaceRepository extends Repository<ParkingSpace> {
  ParkingSpaceRepository._privateConstructor();

  static final ParkingSpaceRepository _instance =
      ParkingSpaceRepository._privateConstructor();

  factory ParkingSpaceRepository() => _instance;
}
