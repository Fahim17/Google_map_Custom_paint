import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'data_table.dart';
import 'data_table_model.dart';
// import 'package:maps_toolkit/maps_toolkit.dart' as mapTool;

class BackCalc {
  /// There will be two types of function in this class. One type of function
  /// will be calculation functions(prefix calc) based on function parameters
  /// and Datatable, another type will be pull functions(prefix pull)
  /// which will pull data directly from the Datatable.
  
  static GoogleMapController myController;

  Map _datatables = DataTable.tables;

  LatLng getLatLngFromPhysical(Offset point) {}
  Offset getPhysicalFromLatLng(LatLng vertex) {}

  double calcLocalDistance(Offset a, Offset b) {}
  double calcTrack(LatLng sV, LatLng eV) {}

//-----------------------------------------------
// this functions are used to get data from Table
//-----------------------------------------------
  double getDistance(String ac, double initialAlt, double finalAlt) {}
  double getTime(String ac, double initialAlt, double finalAlt) {}
  double getFuel(String ac, double initialAlt, double finalAlt) {}

//-----------------------------------------------
// this functions are used to calculate data
//-----------------------------------------------
  double calcDistance(LatLng sV, LatLng eV) {}
  double calcTime(String ac, double distance, double speed) {}
  double calcFuel(
      String ac, double distance, double time, double alt, double speed) {}

  LatLng tocBod(LatLng sV, LatLng eV) {}
  double fuelMinima() {}

  String secToMin() {}
}
