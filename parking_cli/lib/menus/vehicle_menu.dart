import 'package:parking_cli/managers/vehicle_manager.dart';
import 'package:parking_cli/menus/menu.dart';
import 'package:parking_cli/utils/utils.dart';

VehicleManager vehicle = VehicleManager();
Future<void> vehicleMenu(String menuType) async {
  clearScreen();
  final subMenu = Menu(
      'You have choosen to handle ${menuType.toUpperCase()}. Please choose 1-5:',
      {
        1: 'Create new $menuType',
        2: 'Show all $menuType',
        3: 'Update $menuType',
        4: 'Remove $menuType',
        5: 'Back to main menu'
      });

  bool running = true;
  while (running) {
    subMenu.display();
    int? choice = getNumberInput();
    switch (choice) {
      case 1:
        await vehicle.addVehicle();
        break;
      case 2:
        await vehicle.showVehicles();
        break;
      case 3:
        await vehicle.updateVehicle();
        break;
      case 4:
        await vehicle.deleteVehicle();
        break;
      case 5:
        clearScreen();
        return;
      default:
        clearScreen();
        displayWarning('Please choose a valid number');
        break;
    }
  }
}