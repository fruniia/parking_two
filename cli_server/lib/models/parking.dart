import 'package:uuid/uuid.dart';
import 'package:cli_server/models/parking_space.dart';
import 'package:cli_server/models/vehicle.dart';

class Parking {
  String id;
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime start = DateTime.now();
  DateTime? stop;

  void updateStart(DateTime newStart) {
    start = newStart;
  }

  void updateStop(DateTime newStop) {
    stop = newStop;
  }

  Parking(
      {required this.id,
      required this.vehicle,
      required this.parkingSpace,
      this.stop});

  Parking.withUUID({
    required this.vehicle,
    required this.parkingSpace,
    this.stop,
  }) : id = Uuid().v4();
}
