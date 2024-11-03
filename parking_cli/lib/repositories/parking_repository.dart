import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:parking_cli_shared/parking_cli_shared.dart';

class ParkingRepository implements InterfaceRepository<Parking> {
  final baseUrl = "http://localhost:8080/parkings";

  @override
  Future<Parking?> add(Parking parking) async {
    final uri = Uri.parse(baseUrl);
    var jsonData = parking.toJson();
    print(jsonData);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(parking.toJson()),
    );

    if (response.statusCode == 200) {
      return Parking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add parking ${response.body}');
    }
  }

  @override
  Future<Parking?> delete(String id) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response =
        await http.delete(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    return Parking.fromJson(json);
  }

  @override
  Future<List<Parking>> getAll() async {
    final uri = Uri.parse(baseUrl);
    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as List)
          .map((parking) => Parking.fromJson(parking))
          .toList();
    }
    throw Exception('Failed to load parkings');
  }

  @override
  Future<Parking?> getById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response: ${response.body}');
      return Parking.fromJson(data);
    } else {
      print(
          'Failed to load parking: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  @override
  Future<Parking?> update(String id, Parking newParking) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newParking.toJson()));

    final json = jsonDecode(response.body);

    return Parking.fromJson(json);
  }
}
