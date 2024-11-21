import 'package:flutter/material.dart';

class BatteryIndicator extends StatelessWidget {
  final double level;

  const BatteryIndicator({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        Battery(
          width: 100,
          height: 150,
          color: Colors.grey,
          capacity: 85,
        ),

        // Battery cap
      ],
    );
  }
}

class Battery extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double capacity;

  const Battery({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: BatteryPainter(capacity: capacity, color: color),
    );
  }
}

class BatteryPainter extends CustomPainter {
  final double capacity;
  final Color color;
  final double curveSmoothness;

  late double width;
  late double height;
  late double rightBezierX;
  late double leftBezierX;
  late double middleBezierY;
  late double middleControlPointBottom;
  late double curveStartHeight;
  late double curveStartHeightDif;

  BatteryPainter({
    required this.capacity,
    required this.color,
    this.curveSmoothness = .95,
  }) {}

  @override
  void paint(Canvas canvas, Size size) {
    width = size.width;
    height = size.height;
    rightBezierX = width * curveSmoothness;
    leftBezierX = width * (1 - curveSmoothness);

    middleBezierY = height * 0.05;
    middleControlPointBottom = height + middleBezierY;
    curveStartHeight = height * .9; //.9
    curveStartHeightDif = height - curveStartHeight;

    print("height: ${height} \n" +
        "curveStartHeight: ${curveStartHeight} \n" +
        "curveStartHeightDif: ${curveStartHeightDif} \n" +
        "width: ${width} \n" +
        "widthLeftBezierController: ${leftBezierX} \n" +
        "widthRightBezierController: ${rightBezierX} \n" +
        "middleControlPointTop: ${middleBezierY} \n" +
        "middleControlPointBottom: ${middleControlPointBottom} \n");


    paintCapacity(canvas: canvas);
    //paintBody(canvas: canvas);
    //paintTop(canvas: canvas);
  }

  paintBody({canvas}) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from the top-left corner
    path.moveTo(0, -curveStartHeightDif);

    /*Top Curve*/
    path.cubicTo(
        leftBezierX, middleBezierY,
        rightBezierX, middleBezierY,
        width, -curveStartHeightDif,
    );

    path.lineTo(width, curveStartHeight); // Bottom curve start from right side
    path.cubicTo(
        rightBezierX, middleControlPointBottom,
        leftBezierX, middleControlPointBottom,
        0, curveStartHeight //Left curve point
    );
    path.close(); // line to 0,0
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless properties change
  }

  void paintTop({required Canvas canvas}) {
    const double strokeWidth = 8;
    const double strokeHalf = strokeWidth/2;
    final paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    // Start from the top-left corner
    path.moveTo(strokeHalf, -curveStartHeightDif);
    final ab = -((curveStartHeightDif * 2) + middleBezierY);
    path.cubicTo(
      leftBezierX, middleBezierY,
      rightBezierX, middleBezierY,
      width-strokeHalf, -curveStartHeightDif,
    );
    path.cubicTo(
      rightBezierX, ab,
      leftBezierX, ab,
      0+strokeHalf, -curveStartHeightDif,
    );
    path.close(); // line to 0,0
    canvas.drawPath(path, paint);
  }

  void paintCapacity({required Canvas canvas}){

    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path();

    final cap = capacity/100;
    // Start from the top-left corner
    path.moveTo(0, -curveStartHeightDif * cap);

    /*Top Curve*/
    path.cubicTo(
      leftBezierX, middleBezierY,
      rightBezierX, middleBezierY,
      width, -curveStartHeightDif*cap,
    );

    path.lineTo(width, curveStartHeight); // Bottom curve start from right side
    path.cubicTo(
        rightBezierX, middleControlPointBottom,
        leftBezierX, middleControlPointBottom,
        0, curveStartHeight //Left curve point
    );
    path.close(); // line to 0,0
    canvas.drawPath(path, paint);

  }
}
