import 'package:uuid/uuid.dart';

class Person {
  String id;
  String name;
  String socialSecNumber;

  Person({required this.id, required this.name, required this.socialSecNumber});

  Person.withUUID({
    required this.name,
    required this.socialSecNumber,
  }) : id = Uuid().v4();
}
