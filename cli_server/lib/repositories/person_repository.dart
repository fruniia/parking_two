import 'package:cli_server/models/person.dart';
import 'package:cli_server/repositories/repository.dart';

class PersonRepository extends Repository<Person> {
  PersonRepository._privateConstructor();

  static final PersonRepository _instance =
      PersonRepository._privateConstructor();

  factory PersonRepository() => _instance;
}
