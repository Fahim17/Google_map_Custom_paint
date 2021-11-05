import 'dart:html';
import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_map/route_leg.dart';

// import 'route_leg.dart';

class Route {
  String aircraft;
  int routeID;
  String routeName;
  double startingFuel;
  List<Offset> points;

//-----------------------------------------------
//// Settings contains: Starting Fuel, Minima
//-----------------------------------------------
  Object settings;

  List<String> verName;
  // List<double> alt;
  List<LatLng> vertices;
  List<RouteLeg> routeLegs;

  double totalTime;
  double totalFuel;
  double totalDistance;
  double minFuel;
  String reduction;

  Route({this.routeID, this.routeName, this.startingFuel, this.points}) {}

  // void createAllLegs() {}
  void createLegData(/*Settings settings */) {
    /* 
    RouteLeg leg;
    if(routeLegs.length==0){
       leg = RouteLeg(routeLegType: "ST", sPoint, ePoint, );
    }else{
       routeLegs.Last.routeLegType = "EN";
       leg = RouteLeg(routeLegType: "LA", sPoint, ePoint);
    }
    
    leg.setDependency(settings);
    leg.calculate(aircraft, postAlt);    
    
    routeLegs.add(leg);

    calcAllCACF();

    */
  }

  void setAllDF() {}
  void setDF() {}

  void calcAllCF() {}
  void calcCF() {}

  void calcAllCACF() {}
  void calcCACF() {}
}
