import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_map/back_calc.dart';
import 'package:treasure_map/waypoint_Segment.dart';

class RouteLeg {
  /*RouteLeg Types
  **Starting(ST) = this is the first route leg, preAlt=0, /----- 
  **Enroute(EN) = Standard route leg, preAlt !=0, postAlt !=0, -----, /-----,\-----,
  **Landing(LA) = this is the last leg, postAlt =0,-----\, /-----\,\-----\
  */
  String routeLegType;

//-----------------------------------------------
// Settings contains: Alt, Speed
// This settings will be collected from datatable initially after that it can
// be changed by the user and recalculate all proccess
//-----------------------------------------------
  // Object settings;

  Offset sPoint; // get from view
  Offset ePoint; // get from view
  WaypointSegment prelevel;
  WaypointSegment level;
  WaypointSegment postlevel;
//-----------------------------------------------
// Dependency Fields(DF): LatLng * 2, Speed, Alt, preAlt, postAlt, reduction
// Fields those are initialized by parent(Route Class) after constructing
// the instance of this class
//-----------------------------------------------
  LatLng startVertex; // calculate 1
  LatLng endVertex; // calculate 2
  double alt; // get from settings
  // double preAlt; // get from settings
  // double postAlt; // get from settings
  double speed; // get from settings
  String reduction;
//-----------------------------------------------
//-----------------------------------------------

//-----------------------------------------------
// Calculation Fields(CF): distance, track, time, fuel
// Fields those are to be calculated after setting up all dependency field
//-----------------------------------------------
  double distance; // calculate 3
  double track; // calculate 2.5
  double time; // calculate 7
  double fuel; // calculate 8
//-----------------------------------------------
//-----------------------------------------------

//-----------------------------------------------
// Calculation After Calculation(-_-) Fields(CACF): remaining fuel, Minimum fuel
// Fields those are to be calculated after the calculation of the second part
//-----------------------------------------------
  double remainingFuel;
  double minimumFuel;
//-----------------------------------------------
//----------------------------------------------
  // double tocBod;
  // double tocBodTime;

  RouteLeg({this.routeLegType, this.sPoint, this.ePoint}) {
    prelevel = WaypointSegment.prelevel();
    level = WaypointSegment.level();
    postlevel = WaypointSegment.postlevel();
  }

  void setDependency(/*Settings settings */) {
    /*

  startVertex = getLatLngFromPhysical(sPoint); 
  endVertex = getLatLngFromPhysical(ePoint); 

  this.alt = settings.alt;
  this.speed = settings.speed;
  this.reduction = settings.reduction;

    */
  }
  void calcCF(/*String ac, double postAlt*/) {
    /*
  distance = calcDistance(startVertex, endVertex);
  track = calcTrack(startVertex, endVertex);

  prelevel.distance = getDistance(aircraft, alt, postAlt);
  prelevel.time = getTime(aircraft, alt, postAlt);
  prelevel.fuel = getFuel(aircraft, alt, postAlt);

  postlevel.distance = getDistance(aircraft, alt, postAlt);
  postlevel.time = getTime(aircraft, alt, postAlt);
  postlevel.fuel = getFuel(aircraft, alt, postAlt);

  level.distance = (prelevel.distance+postlevel.distance) - distance;
  level.time = calcTime();
  level.fuel = calcFuel();
   
  time = prelevel.time+level.time+postlevel.time;
  fuel = prelevel.fuel+level.fuel+postlevel.fuel;

    
     */
  }
  void calcCACF() {}
}
