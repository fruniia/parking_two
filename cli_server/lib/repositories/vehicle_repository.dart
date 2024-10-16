import 'package:cli_server/models/vehicle.dart';
import 'package:cli_server/repositories/repository.dart';

class VehicleRepository extends Repository<Vehicle> {
  VehicleRepository._privateConstructor();
  static final VehicleRepository _instance =
      VehicleRepository._privateConstructor();

  factory VehicleRepository() => _instance;
  static final List<Vehicle> _vehicles = [];

  List<Vehicle> get allVehicles => _vehicles;

  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    add(vehicle);
  }

  void removeVehicle(Vehicle vehicle){
    _vehicles.remove(vehicle);
      delete(vehicle);
    }

  void updateVehicle(int index, Vehicle updatedVehicle) {
    _vehicles[index].owner = updatedVehicle.owner;
    _vehicles[index].licensePlate = updatedVehicle.licensePlate;
    _vehicles[index].vehicleType = updatedVehicle.vehicleType;
    update(index, updatedVehicle);
  }
}

