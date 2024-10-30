import 'package:parking_cli_shared/parking_cli_shared.dart';

class VehicleDataStore implements InterfaceRepository<Vehicle> {
  String filePath = '../cli_server/vehicles.json';
  @override
  Future<Vehicle?> add(Vehicle item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Vehicle?> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Vehicle>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Vehicle?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<Vehicle?> update(String id, Vehicle newItem) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
