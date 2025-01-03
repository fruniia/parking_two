import 'package:parking_cli/repositories/person_repository.dart';
import 'package:parking_cli/utils/utils.dart';
import 'package:parking_cli_shared/parking_cli_shared.dart';

class PersonManager {
  PersonRepository personRepos = PersonRepository();
  Future<void> deletePerson() async {
    var persons = await showPersons();
    if (persons.isNotEmpty) {
      displayInfo('Please enter index to delete?');
      var index = getNumberInput();
      if (index != null && index >= 0 && index < persons.length) {
        displayWarning('Do you really want to delete? (Y/N)');
        var str = getTextInput();
        if (str != null && str.toLowerCase() == 'y') {
          await personRepos.delete(persons[index].id);
        }
      }
    } else {
      displayInfo('Nothing to delete');
    }
  }

  Future<void> updatePerson() async {
    var persons = await showPersons();
    if (persons.isNotEmpty) {
      displayInfo(
          'Please choose index (${persons.length == 1 ? '0' : '0-${persons.length - 1}'})');
      var index = getNumberInput();

      if (index != null) {
        var personToUpdate = persons[index];
        displayInfo('Update your name: ');
        var newName = getTextInput();
        if (newName != null) {
          print('Old name: ${personToUpdate.name} New name: $newName');
          displayWarning('Do you really want to update? (Y/N)');
          var str = getTextInput();
          if (str != null && str.toLowerCase() == 'y') {
            displaySuccess('New name: $newName');
            Person newPerson = Person(
                id: personToUpdate.id,
                name: newName,
                socialSecNumber: personToUpdate.socialSecNumber);
            await personRepos.update(personToUpdate.id, newPerson);
          } else {
            displayInfo('No update.');
          }
        }
      }
    } else {
      displayInfo('Nothing to update');
    }
  }

  Future<void> addPerson() async {
    displayInfo("Enter your name:");
    var newName = getTextInput();
    var ssn = _setSocSecNum();
    if (newName != null && ssn != '') {
      Person person = Person.withUUID(name: newName, socialSecNumber: ssn);

      try {
        await personRepos.add(person);
      } catch (e) {
        handleError(e as Exception);
      }
    } else {
      displayWarning('Nope!');
    }
  }

  String _setSocSecNum() {
    bool isValid = false;
    String? ssn;
    while (!isValid) {
      displayInfo('Please enter socialsecuritynumber (YYYYMMDDXXXX):');
      ssn = getTextInput();
      if (ssn != null) {
        if (ssn.length == 12) {
          isValid = _isValidLuhn(ssn);
        }
        isValid ? displaySuccess('Valid ssn') : displayWarning('Invalid ssn');
      }
    }
    return ssn ?? '';
  }

  Future<List<Person>> showPersons() async {
    try {
      List<Person> persons = await personRepos.getAll();

      if (persons.isNotEmpty) {
        for (int index = 0; index < persons.length; index++) {
          var person = persons[index];
          print(
              'Index $index: Name: ${person.name} SSN: ${person.socialSecNumber}');
        }
        return persons;
      } else {
        print('No persons registered');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  bool _isValidLuhn(String ssn) {
    if (ssn.length != 12) return false;
    int sum = 0;

    //Skip first two digits in ssn
    for (int i = 2; i < ssn.length - 1; i++) {
      int digit = int.parse(ssn[i]);

      //Multiply first digit with 2, second with 1, third with 2...
      int multiplier = (ssn.length - 2 - i) % 2 == 0 ? 2 : 1;
      digit *= multiplier;

      if (digit > 9) {
        //If digit > 9, e.g. 14 add them 1 + 4
        sum += (digit ~/ 10) + (digit % 10);
      } else {
        //else add them to sum
        sum += digit;
      }
    }
    int checkDigit = int.parse(ssn[ssn.length - 1]);
    return (sum + checkDigit) % 10 == 0;
  }
}
