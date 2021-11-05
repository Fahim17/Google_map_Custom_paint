import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'maps.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mapTool;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainMap(),
    );
  }
}

class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  List<Offset> _offsets = <Offset>[];
  Offset _startpoint = null;
  Offset _endpoint = null;
  List<LatLng> latlng = [];

  GoogleMapController myController;
  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  final CameraPosition position = CameraPosition(
    target: LatLng(23.810331, 90.412521),
    zoom: 12,
  );

  bool mapDrag = true;
  Offset drag = null;
  LatLng preCenterLatLng = LatLng(23.810331, 90.412521);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Offset centerOffset = Offset(width / 2, height / 2);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('The Treasure Mapp'),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // for (int y = 0; y < _offsets.length; y++) {
            //   LatLng temp = await offsetToLatLng(_offsets[y], context);
            //   latlng.add(temp);
            // }

            if (mapDrag) {
              mapDrag = false;
            } else {
              mapDrag = true;
            }
            print('mapDrag: $mapDrag');
          });
        },
        child: Icon(Icons.timeline),
        backgroundColor: (mapDrag) ? Colors.red : Colors.green,
      ),

      body: GestureDetector(
        onPanDown: (details) {
          if (!mapDrag) {
            setState(() {
              //_offsets.add(details.localPosition);
              _startpoint = details.localPosition;

              print('ON PAN DOWN');
            });
          }
        },
        onPanUpdate: (details) {
          if (!mapDrag) {
            setState(() {
//             _offsets.add(details.localPosition);
              _endpoint = details.localPosition;
              print('ON PAN UPDATE');
            });
          }
        },
        onPanEnd: (details) async {
          LatLng stlatlng = await offsetToLatLng(_startpoint, context);
          LatLng enlatlng = await offsetToLatLng(_endpoint, context);

          double angle = (_endpoint - _startpoint).direction;
          double angleMod = (angle + 360) % 360;

          double disMeter = mapTool.SphericalUtil.computeDistanceBetween(
              mapTool.LatLng(stlatlng.latitude, stlatlng.longitude),
              mapTool.LatLng(enlatlng.latitude, enlatlng.longitude));

          double track = mapTool.SphericalUtil.computeHeading(
              mapTool.LatLng(stlatlng.latitude, stlatlng.longitude),
              mapTool.LatLng(enlatlng.latitude, enlatlng.longitude));

          double trackMod = (track + 360) % 360;

          print('starting LatLng: $stlatlng');
          print('ending LatLng: $enlatlng');
          print('distance in meters: $disMeter');
          print('Track: $trackMod');
          print('Angle: $angleMod');

          if (!mapDrag) {
            setState(() {
              _offsets.add(_startpoint);
              _offsets.add(_endpoint);

              latlng.add(stlatlng);
              latlng.add(enlatlng);

              _startpoint = null;
              _endpoint = null;
              print('ON PAN END');
            });
          }
        },
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              // compassEnabled: true,

              zoomControlsEnabled: false,
              scrollGesturesEnabled: mapDrag,
              rotateGesturesEnabled: false,
              initialCameraPosition: position,
              onMapCreated: _onMapCreated,
              gestureRecognizers: Set()
                ..add(Factory<PanGestureRecognizer>(
                    () => PanGestureRecognizer())),
              onCameraMove: (position) async {
                // Offset temp = await latlngToOffset(preCenterLatLng, context);
                // print('temp: ${temp}');

                setState(() {
                  // drag = temp - centerOffset;
                  // // _offsets = _offsets.map((e) => e + drag).toList();
                  // for (int y = 0; y < _offsets.length; y++) {
                  //   _offsets[y] = _offsets[y] + drag;
                  // }
                  // preCenterLatLng = position.target;
// *****************************************************************************
                  _offsets.clear();
                });
              },

              onCameraIdle: () async {
                List<Offset> ofst = [];

                for (int x = 0; x < latlng.length; x++) {
                  Offset temp = await latlngToOffset(latlng[x], context);
                  ofst.add(temp);
                }
                setState(() {
                  _offsets = ofst;
                });
              },
            ),
            IgnorePointer(
              ignoring: mapDrag,
              child: CustomPaint(
                  painter: FlipBookPainter(_offsets, _startpoint, _endpoint),
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  child: IgnorePointer(
                    ignoring: mapDrag,
                    child: Container(
                      color: Colors.transparent,
                      // child: Text("hello"),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<Offset> latlngToOffset(LatLng llg, BuildContext context) async {
    ScreenCoordinate ss = await myController.getScreenCoordinate(llg);
    double xx = ss.x / MediaQuery.of(context).devicePixelRatio;
    double yy = ss.y / MediaQuery.of(context).devicePixelRatio;
    return Offset(xx, yy);
  }

  Future<LatLng> offsetToLatLng(Offset ofs, BuildContext context) async {
    int tx = (ofs.dx * MediaQuery.of(context).devicePixelRatio).toInt();
    int ty = (ofs.dy * MediaQuery.of(context).devicePixelRatio).toInt();

    LatLng ll = await myController.getLatLng(ScreenCoordinate(x: tx, y: ty));
    return ll;
  }

  // Future<List<Offset>> latlngtoOffsetList(
  //     List<LatLng> lst, BuildContext context) async {
  //   List<Offset> offsets = [];
  //   for (LatLng x in lst) {
  //     Offset temp = await latlngToOffset(x, context);
  //     offsets.add(temp);
  //   }

  //   return offsets;
  // }
}
