import 'package:treasure_map/back_calc.dart';

class WaypointSegment with BackCalc {
  String type;

  double time;
  double distance;
  double fuel;

  // double preAlt;
  // double alt;

  // double preLevelDistance = 0;
  // double postLevelDistance = 0;
  // double legDistance = 0;

  WaypointSegment.prelevel({this.type = 'prelevel'}) {
/** if preAlt == alt: time, distance, fuel will be 0 else pull data from datatable**/
  }

  WaypointSegment.level({this.type = 'level'});

  WaypointSegment.postlevel({this.type = 'postlevel'}) {
    /** check if it is a landing type route leg then pull data form datatable **/
  }
}
