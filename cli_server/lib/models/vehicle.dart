import 'package:uuid/uuid.dart';
import 'package:cli_server/enums/vehicle_type.dart';
import 'package:cli_server/models/person.dart';

class Vehicle {
  String id;
  String licensePlate;
  Person owner;
  VehicleType vehicleType;

  Vehicle(
      {required this.id,
      required this.licensePlate,
      required this.owner,
      required this.vehicleType});

  Vehicle.withUUID({
    required this.licensePlate,
    required this.owner,
    required this.vehicleType,
  }) : id = Uuid().v4();
}
