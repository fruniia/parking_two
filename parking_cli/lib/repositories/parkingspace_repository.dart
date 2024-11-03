import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:parking_cli_shared/parking_cli_shared.dart';

class ParkingSpaceRepository implements InterfaceRepository<ParkingSpace> {
  final baseUrl = "http://localhost:8080/parkingSpaces";

  @override
  Future<List<ParkingSpace>> getAll() async {
    final uri = Uri.parse(baseUrl);
    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as List)
          .map((parkingSpace) => ParkingSpace.fromJson(parkingSpace))
          .toList();
    }
    throw Exception('Failed to load parkingspaces');
  }

  @override
  Future<ParkingSpace?> delete(String id) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response =
        await http.delete(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    return ParkingSpace.fromJson(json);
  }

  @override
  Future<ParkingSpace?> getById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response: ${response.body}');
      return ParkingSpace.fromJson(data);
    } else {
      print(
          'Failed to load parkingspace: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  @override
  Future<ParkingSpace?> update(String id, ParkingSpace newParkingSpace) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newParkingSpace.toJson()));

    final json = jsonDecode(response.body);

    return ParkingSpace.fromJson(json);
  }

  @override
  Future<ParkingSpace?> add(ParkingSpace item) async {
    final uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return ParkingSpace.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to add parkingspace ${response.body}');
  }
}
