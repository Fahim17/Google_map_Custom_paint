import 'dart:ui';

import 'package:flutter/material.dart';

class FlipBookPainter extends CustomPainter {
  final List<Offset> offsets;
  Offset startpoint;
  Offset endpoint;

  FlipBookPainter(this.offsets, this.startpoint, this.endpoint);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..isAntiAlias = true
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    // for (var offset in offsets) {
    //   debugPrint('offset = $offset');
    //   canvas.drawPoints(PointMode.points, [offset], paint);
    // }
    for (var i = 0; i < offsets.length; i += 2) {
      if (offsets[i] != null &&
          i + 1 < offsets.length &&
          offsets[i + 1] != null) {
        canvas.drawLine(offsets[i], offsets[i + 1], paint);
      } else if (offsets[i] != null &&
          i + 1 < offsets.length &&
          offsets[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [offsets[i]], paint);
      }
    }

//     Drawing putuli
    for (var i = 0; i < offsets.length; i += 1) {
      canvas.drawCircle(offsets[i], 4, paint);
    }

//    Drawing line
    if (startpoint != null && endpoint != null) {
      canvas.drawLine(startpoint, endpoint, paint);
      drawCrosshair(endpoint, canvas, size);
//       double l= 180/math.pi;
//       double t = (startpoint-endpoint).direction*l;
// //       double theta = (t>=0) ?:;
//       print((t+270)%360);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawCrosshair(Offset endpoint, Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..strokeJoin = StrokeJoin.round;
    //draw vertical line
    var a1 = Offset(endpoint.dx, 0);
    var b1 = Offset(endpoint.dx, size.height);
    canvas.drawLine(a1, b1, paint);

    //draw horizontal line
    var a2 = Offset(0, endpoint.dy);
    var b2 = Offset(size.width, endpoint.dy);
    canvas.drawLine(a2, b2, paint);
  }
}
