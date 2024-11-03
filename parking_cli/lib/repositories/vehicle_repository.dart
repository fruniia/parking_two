import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_cli_shared/parking_cli_shared.dart';

class VehicleRepository implements InterfaceRepository<Vehicle> {
  final baseUrl = "http://localhost:8080/vehicles";
  @override
  Future<List<Vehicle>> getAll() async {
    final uri = Uri.parse(baseUrl);
    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as List)
          .map((vehicle) => Vehicle.fromJson(vehicle))
          .toList();
    }
    throw Exception('Failed to load vehicles');
  }

  @override
  Future<Vehicle?> add(Vehicle vehicle) async {
    final uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vehicle.toJson()),
    );

    if (response.statusCode == 200) {
      return Vehicle.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to add vehicle ${response.body}');
  }

  @override
  Future<Vehicle?> delete(String id) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response =
        await http.delete(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    return Vehicle.fromJson(json);
  }

  @override
  Future<Vehicle?> getById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response: ${response.body}');
      return Vehicle.fromJson(data);
    } else {
      print(
          'Failed to load vehicle: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  @override
  Future<Vehicle?> update(String id, Vehicle newVechicle) async {
    final uri = Uri.parse('$baseUrl/$id');
    print(newVechicle.toJson());
    final response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newVechicle.toJson()));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print('Response: ${response.body}');
      return Vehicle.fromJson(json);
    } else {
      print('Failed to load vehicle: ${response.statusCode} - ${response.body}');
      return null;
    }
  }
}
