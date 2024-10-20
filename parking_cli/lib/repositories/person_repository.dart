import 'package:parking_cli/models/person.dart';
import 'package:parking_cli/repositories/repository.dart';

class PersonRepository extends Repository<Person> {
  PersonRepository._privateConstructor();

  static final PersonRepository _instance =
      PersonRepository._privateConstructor();

  factory PersonRepository()  => _instance;
}
