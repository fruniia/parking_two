import 'dart:convert';

import 'package:parking_cli_shared/parking_cli_shared.dart';
import 'package:http/http.dart' as http;

class PersonRepository implements InterfaceRepository<Person> {
  final baseUrl = "http://localhost:8080/persons";
  @override
  Future<Person?> add(Person person) async {
    final uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(person.toJson()),
    );

    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to add person');
  }

  @override
  Future<Person?> delete(String id) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response =
        await http.delete(uri, headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }

  @override
  Future<List<Person>> getAll() async {
    final uri = Uri.parse(baseUrl);
    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as List).map((person) => Person.fromJson(person)).toList();
    }
    throw Exception('Failed to load persons');
  }

  @override
  Future<Person?> getById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      return Person.fromJson(data);
    } else {
      print('Failed to load person: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  @override
  Future<Person?> update(String id, Person newItem) async {
    final uri = Uri.parse('$baseUrl/$id');

    final response = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newItem.toJson()));

    final json = jsonDecode(response.body);

    return Person.fromJson(json);
  }
}
