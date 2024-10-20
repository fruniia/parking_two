import 'package:parking_cli/models/parking_space.dart';
import 'package:parking_cli/repositories/repository.dart';

class ParkingSpaceRepository extends Repository<ParkingSpace> {
  ParkingSpaceRepository._privateConstructor();

  static final ParkingSpaceRepository _instance =
      ParkingSpaceRepository._privateConstructor();

  factory ParkingSpaceRepository() => _instance;
}
