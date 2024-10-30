import 'dart:convert';

import 'package:cli_server/repositories/vehicle_data_store.dart';
import 'package:parking_cli_shared/parking_cli_shared.dart';
import 'package:shelf/shelf.dart';
//import 'package:shelf_router/shelf_router.dart';

VehicleDataStore vehicleRepo = VehicleDataStore();

Future<Response> postVehicleHandler(Request req) async {
  try {
    final data = await req.readAsString();
    final json = jsonDecode(data);

    Vehicle? vehicle = Vehicle.fromJson(json);

    vehicle = await vehicleRepo.add(vehicle);

    return Response.ok(jsonEncode(vehicle),
        headers: {'Content-Type': 'application/json'});
  } catch (e) {
    return Response.internalServerError(
        body: jsonEncode({'error': 'Something went wrong: ${e.toString()}'}),
        headers: {'Content-Type': 'application/json'});
  }
}

Future<Response> getVehiclesHandler(Request req) async {
  try {
    var vehicles = await vehicleRepo.getAll();

    final payload = vehicles.map((vehicle) => vehicle.toJson()).toList();
    print(payload);

    return Response.ok(jsonEncode(payload),
        headers: {'Content-Type': 'application/json'});
  } catch (e) {
    return Response.internalServerError(
      body: jsonEncode({'error': 'Something went wrong: ${e.toString()}'}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

Future<Response> putVehiclesHandler(Request req) async {
  // TODO: implement getById
  throw UnimplementedError();
}

Future<Response> getVehicleHandler(Request request) async {
  // TODO: implement getById
  throw UnimplementedError();
}

Future<Response> deleteVehicleHandler(Request req) async {
  // TODO: implement getById
  throw UnimplementedError();
}
