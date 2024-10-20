import 'package:uuid/uuid.dart';
import 'package:parking_cli/models/parking_space.dart';
import 'package:parking_cli/models/vehicle.dart';

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
      {required this.id, required this.vehicle, required this.parkingSpace});

  Parking.withUUID({
    required this.vehicle,
    required this.parkingSpace,
  }) : id = Uuid().v4();

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'],
      vehicle: json['vehicle'],
      parkingSpace: json['parkingSpace'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle': vehicle.toJson(),
      'parkingSpace': parkingSpace.toJson()
    };
  }
}
