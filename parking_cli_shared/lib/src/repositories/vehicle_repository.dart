import 'package:parking_cli_shared/parking_cli_shared.dart';

class VehicleRepository extends Repository<Vehicle> {
  VehicleRepository._privateConstructor();
  static final VehicleRepository _instance =
      VehicleRepository._privateConstructor();

  factory VehicleRepository() => _instance;
}
