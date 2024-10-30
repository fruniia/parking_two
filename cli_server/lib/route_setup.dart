import 'package:cli_server/handlers/person_handler.dart';
import 'package:cli_server/handlers/vehicle_handler.dart';
import 'package:shelf_router/shelf_router.dart';

class ServerSetup {
  ServerSetup._privateConstructor() {
    setUpRoutes();
  }

  static final ServerSetup _instance = ServerSetup._privateConstructor();
  static ServerSetup get instance => _instance;

  //Declaration without initialization
  late Router router;

  Future setUpRoutes() async {
    router = Router();

    //-- Persons --
    router.get('/persons', getPersonsHandler);
    router.get('/persons/<id>', getPersonHandler);
    router.post('/persons', postPersonHandler);
    router.put('/persons/<id>', putPersonsHandler);
    router.delete('/persons/<id>', deletePersonHandler);

    //-- Vehicles --
    router.post('/vehicles', postVehicleHandler);
    router.get('/vehicles', getVehiclesHandler);
    router.get('/vehicles/<id>', getVehicleHandler);
    router.put('/vehicles/<id>', putVehiclesHandler);
    router.delete('/vehicles/<id>', deletePersonHandler);
  }
}
