import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class DottedBorderContainer extends StatelessWidget {

  const DottedBorderContainer({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scanning Image', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  painter: DottedBorderPainter(),
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Icon(FontAwesomeIcons.brain, size: 80,color: Colors.indigo.shade400,),
                          SizedBox(height: 20,),
                          Text('Scan MRI Image', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                        ]
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                CustomPaint(
                  painter: DottedBorderPainter(),
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Icon(FontAwesomeIcons.camera, size: 80,color: Colors.indigo.shade300,),
                            SizedBox(height: 20,),
                            Text('Scan Prescription Image', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                          ]
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4;
    const double dashSpace = 4;
    double startX = 0;
    double startY = 0;

    final path = Path();
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));

    path.addRRect(rrect);

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final Path extractPath = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}