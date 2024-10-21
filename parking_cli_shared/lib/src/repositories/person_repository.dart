import 'package:parking_cli_shared/parking_cli_shared.dart';

class PersonRepository extends Repository<Person> {
  PersonRepository._privateConstructor();

  static final PersonRepository _instance =
      PersonRepository._privateConstructor();

  factory PersonRepository()  => _instance;
}
