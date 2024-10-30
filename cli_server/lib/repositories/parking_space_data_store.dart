import 'package:parking_cli_shared/parking_cli_shared.dart';

class ParkingSpaceDataStore implements InterfaceRepository<ParkingSpace>{
  String filePath = '../cli_server/parkingSpaces.json';
  @override
  Future<ParkingSpace?> add(ParkingSpace item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<ParkingSpace?> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ParkingSpace>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<ParkingSpace?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<ParkingSpace?> update(String id, ParkingSpace newItem) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
}