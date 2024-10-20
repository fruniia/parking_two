import 'package:uuid/uuid.dart';
import 'package:cli_server/models/parking_space.dart';
import 'package:cli_server/models/vehicle.dart';

class Parking {
  String id;
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime _start = DateTime.now();
  DateTime? _stop;

  void updateStart(DateTime newStart) {
    _start = newStart;
  }

  void updateStop(DateTime newStop) {
    _stop = newStop;
  }

  DateTime? get stop => _stop;
  DateTime get start => _start;

  Parking(
      {required this.id,
      required this.vehicle,
      required this.parkingSpace});

  Parking.withUUID({
    required this.vehicle,
    required this.parkingSpace,
  }) : id = Uuid().v4();
}