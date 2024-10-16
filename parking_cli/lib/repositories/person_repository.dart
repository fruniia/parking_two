import 'package:parking_cli/models/person.dart';
import 'package:parking_cli/repositories/repository.dart';

class PersonRepository extends Repository<Person> {
  PersonRepository._privateConstructor();

  static final PersonRepository _instance =
      PersonRepository._privateConstructor();

  factory PersonRepository() => _instance;
  static final List<Person> _persons = [];

  List<Person> get allPersons => _persons;

  void addPerson(Person person) {
    _persons.add(person);
    add(person);
  }

  void removePerson(Person person) {
    _persons.remove(person);
    delete(person);
  }

  //Only option is to update name
  void updatePerson(int index, Person updatedPerson) {
    _persons[index].name = updatedPerson.name;
    update(index, updatedPerson);
  }
}
