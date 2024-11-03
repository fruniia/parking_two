import 'package:parking_cli_shared/parking_cli_shared.dart';
import 'package:uuid/uuid.dart';

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
    var parking = Parking(
      id: json['id'],
      vehicle: Vehicle.fromJson(json['vehicle']),
      parkingSpace: ParkingSpace.fromJson(json['parkingSpace']),
    );

    parking.updateStart(DateTime.parse(json['start']));

    if (json['stop'] != null) {
      parking.updateStop(DateTime.parse(json['stop']));
    } 
    return parking;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle': vehicle.toJson(),
      'parkingSpace': parkingSpace.toJson(),
      'start': _start.toIso8601String(), //Convert to string
      'stop': _stop?.toIso8601String(), //Convert to string, could be null
    };
  }
}
