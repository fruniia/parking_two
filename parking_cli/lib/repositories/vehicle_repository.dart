import 'package:parking_cli/models/vehicle.dart';
import 'package:parking_cli/repositories/repository.dart';

class VehicleRepository extends Repository<Vehicle> {
  VehicleRepository._privateConstructor();
  static final VehicleRepository _instance =
      VehicleRepository._privateConstructor();

  factory VehicleRepository() => _instance;
}
