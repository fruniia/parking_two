import 'package:cli_server/models/vehicle.dart';
import 'package:cli_server/repositories/repository.dart';

class VehicleRepository extends Repository<Vehicle> {
  VehicleRepository._privateConstructor();
  static final VehicleRepository _instance =
      VehicleRepository._privateConstructor();

  factory VehicleRepository() => _instance;
}

