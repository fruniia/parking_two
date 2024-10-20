import 'package:cli_server/models/parking.dart';
import 'package:cli_server/repositories/repository.dart';

class ParkingRepository extends Repository<Parking> {
  ParkingRepository._privateConstructor();

  static final ParkingRepository _instance =
      ParkingRepository._privateConstructor();

  factory ParkingRepository() => _instance;
}
