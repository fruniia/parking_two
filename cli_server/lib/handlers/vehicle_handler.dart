//import 'dart:convert';

import 'package:cli_server/repositories/vehicle_data_store.dart';
//import 'package:parking_cli_shared/parking_cli_shared.dart';
import 'package:shelf/shelf.dart';
//import 'package:shelf_router/shelf_router.dart';

VehicleDataStore vehicleRepo = VehicleDataStore();
final vehicles = [];

Future<Response> postVehicleHandler(Request req) async {
  // TODO: implement getById
  throw UnimplementedError();
}

Future<Response> getVehiclesHandler(Request req) async {
  // TODO: implement getById
  throw UnimplementedError();
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
