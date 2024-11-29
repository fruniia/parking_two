import 'package:parking_cli/utils/fetch_data.dart';
import 'package:parking_cli_shared/parking_cli_shared.dart';

class VehicleRepository implements InterfaceRepository<Vehicle> {
  final baseUrl = "http://localhost:8080/vehicles";

  @override
  Future<Vehicle?> add(Vehicle vehicle) async {
    return await fetchData<Vehicle>(
      url: baseUrl,
      method: 'POST',
      body: vehicle.toJson(),
      fromJson: (data) => Vehicle.fromJson(data),
    );
  }

  @override
  Future<Vehicle?> delete(String id) async {
    return await fetchData<Vehicle>(
      url: '$baseUrl/$id',
      method: 'DELETE',
      fromJson: (data) => Vehicle.fromJson(data),
    );
  }

  @override
  Future<List<Vehicle>> getAll() async {
    return await fetchData<List<Vehicle>>(
      url: baseUrl,
      method: 'GET',
      fromJson: (data) {
        return (data as List)
            .map((vehicle) => Vehicle.fromJson(vehicle))
            .toList();
      },
    );
  }

  @override
  Future<Vehicle?> getById(String id) async {
    return await fetchData<Vehicle>(
      url: '$baseUrl/$id',
      method: 'GET',
      fromJson: (data) => Vehicle.fromJson(data),
    );
  }

  @override
  Future<Vehicle?> update(String id, Vehicle newItem) async {
    return await fetchData<Vehicle>(
      url: '$baseUrl/$id',
      method: 'PUT',
      body: newItem.toJson(),
      fromJson: (data) => Vehicle.fromJson(data),
    );
  }
}
