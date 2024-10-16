import 'package:uuid/uuid.dart';

class ParkingSpace {
  String id;
  String address;
  double pricePerHour;

  ParkingSpace(
      {required this.id, required this.address, required this.pricePerHour});
  ParkingSpace.withUUID({required this.address, required this.pricePerHour})
      : id = Uuid().v4();
}
