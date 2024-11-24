import 'package:flutter/material.dart';

class BatteryIndicator extends StatelessWidget {
  final double capacity;

  const BatteryIndicator({super.key, required this.capacity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Battery(
              width: 100,
              height: 150,
              color: Colors.grey,
              capacity: capacity,
            ),
            const Icon(
              Icons.flash_on,
              color: Colors.yellow,
              size: 44,
            )

            // Battery cap
          ],
        ),
        Text("${capacity.toInt()} %",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white))
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
  final double curveSmoothness = 1;

  late double width;
  late double height;
  late double rightBezierX;
  late double leftBezierX;

  late double deltaH;
  late double batteryHeight;

  BatteryPainter({
    required this.capacity,
    required this.color,
  }) {}

  @override
  void paint(Canvas canvas, Size size) {
    width = size.width;
    height = size.height;
    rightBezierX = width * curveSmoothness;
    leftBezierX = width * (1 - curveSmoothness);

    /** New method */
    deltaH = height * .15;
    batteryHeight = height - deltaH;

    paintEmptyCapacity(canvas: canvas);
    paintCapacity(canvas: canvas);
    paintTop(canvas: canvas);

    //painBorder(canvas: canvas);
  }

  void painBorder({required Canvas canvas}) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromPoints(Offset.zero, Offset(width, height)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless properties change
  }

  void paintTop({required Canvas canvas}) {
    double strokeWidth = width * .04;
    double strokeHalf = strokeWidth / 2;
    final paint = Paint()
      ..color = const Color(0xff57f3ba)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();

    double startX = strokeHalf;
    const double startY = 0;

    var topLeft = Offset(startX, startY);
    var topRight = Offset(width - strokeHalf, startY);

    path.moveTo(topLeft.dx, topLeft.dy);

    path.cubicTo(leftBezierX, deltaH, rightBezierX, deltaH, topRight.dx,
        topRight.dy //Left curve point
        );

    // From Right top to left top with a negative curve
    path.cubicTo(rightBezierX, -deltaH, leftBezierX, -deltaH, topLeft.dx,
        topLeft.dy //Left curve point
        );

    path.close(); // line to 0,0
    canvas.drawPath(path, paint);

    /** Paint the grey cover*/

    final path2 = Path();
    final capdisp = strokeHalf;

    final paint2 = Paint()
      ..color = const Color(0xffb8b9b9)
      ..style = PaintingStyle.fill;

    path2.moveTo(topLeft.dx + capdisp, topLeft.dy);
    path2.cubicTo(
        leftBezierX + capdisp,
        deltaH - capdisp,
        rightBezierX - capdisp,
        deltaH - capdisp,
        topRight.dx - capdisp,
        topRight.dy //Left curve point
        );

    // From Right top to left top with a negative curve
    path2.cubicTo(
        rightBezierX - capdisp,
        -deltaH + capdisp,
        leftBezierX + capdisp,
        -deltaH + capdisp,
        topLeft.dx + capdisp,
        topLeft.dy //Left curve point
        );

    path2.close(); // line to 0,0
    canvas.drawPath(path2, paint2);

    paintTip(canvas: canvas);
  }

  void paintTip({required Canvas canvas}) {
    /** pain the tip */

    final double startX = width * .35;
    final double endX = width * (1 - .35);
    const double startY = 0;

    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final path = Path();

    final double tipHeight = height * .04;

    var topLeft = Offset(startX, startY);
    var bottomLeft = Offset(startX, 0);

    var bottomRight = Offset(endX, 0);
    var topRight = Offset(endX, startY);

    // Start from the top-left corner
    path.moveTo(bottomLeft.dx, bottomLeft.dy);
    path.cubicTo(bottomLeft.dx, tipHeight, bottomRight.dx, tipHeight,
        bottomRight.dx, bottomRight.dy //Left curve point
        );
    path.lineTo(topRight.dx, topRight.dy - tipHeight);
    /*Top Curve*/
    path.cubicTo(
      bottomRight.dx,
      0,
      bottomLeft.dx,
      0,
      topLeft.dx,
      topLeft.dy - tipHeight,
    );
    path.close();
    canvas.drawPath(path, paint);

    /** Paint tips oval top*/
  }

  void paintEmptyCapacity({required Canvas canvas}) {
    const double startX = 0;
    const double startY = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(colors: [
        Color(0xff4d5872),
        Color(0xff9da3b0),
        Color(0xff383f4f),
        Color(0xff2d3447),
        Color(0xff2a3246),
        Color(0xff2d3447),
        Color(0xff383f4f),
        Color(0xff9da3b0),
        Color(0xff4d5872),
      ]).createShader(Rect.fromPoints(Offset.zero, Offset(width, height)));

    final double emptyHeight = batteryHeight * (100 - capacity) / 100;

    var topLeft = const Offset(startX, startY);
    var bottomLeft = Offset(startX, emptyHeight);

    var bottomRight = Offset(width, emptyHeight);
    var topRight = Offset(width, startY);

    final path = Path();

    // Start from the top-left corner
    path.moveTo(bottomLeft.dx, bottomLeft.dy);
    path.cubicTo(leftBezierX, emptyHeight - deltaH, rightBezierX,
        emptyHeight - deltaH, bottomRight.dx, bottomRight.dy //Left curve point
        );
    path.lineTo(topRight.dx, topRight.dy);
    /*Top Curve*/
    path.cubicTo(
      rightBezierX,
      deltaH,
      leftBezierX,
      deltaH,
      topLeft.dx,
      topLeft.dy,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  void paintCapacity({required Canvas canvas}) {
    const double startX = 0;
    const double startY = 0;

    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(colors: [
        Color(0xff10db90),
        Color(0xff7af5c9),
        Color(0xff7af5c9),
        Color(0xff10db90),
      ]).createShader(
          Rect.fromPoints(const Offset(0, 0), const Offset(100, 100)));

    final capacityHeight = batteryHeight - batteryHeight * capacity / 100;

    var topLeft = Offset(startX, capacityHeight);
    var bottomLeft = Offset(startY, height - deltaH);

    var bottomRight = Offset(width, height - deltaH);
    var topRight = Offset(width, capacityHeight);

    final path = Path();

    // Start from the top-left corner
    path.moveTo(bottomLeft.dx, bottomLeft.dy);
    path.cubicTo(leftBezierX, height, rightBezierX, height, bottomRight.dx,
        bottomRight.dy //Left curve point
        );
    path.lineTo(topRight.dx, topRight.dy);
    /*Top Curve*/
    path.cubicTo(
      rightBezierX,
      capacityHeight + deltaH,
      leftBezierX,
      capacityHeight + deltaH,
      topLeft.dx,
      topLeft.dy,
    );
    path.close();
    canvas.drawPath(path, paint);

    // inside oval

    final path2 = Path();

    final paint2 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff5cf3bc),
            Color(0xfff4fefb),
          ]).createShader(Rect.fromPoints(
        Offset(topLeft.dx - deltaH, topLeft.dy - deltaH),
        Offset(topRight.dx + deltaH, topLeft.dy + deltaH),
      ));

    path2.moveTo(topRight.dx, topRight.dy);
    /*Top Curve*/
    path2.cubicTo(
      rightBezierX,
      capacityHeight + deltaH,
      leftBezierX,
      capacityHeight + deltaH,
      topLeft.dx,
      topLeft.dy,
    );

    path2.cubicTo(
      leftBezierX,
      capacityHeight - deltaH,
      rightBezierX,
      capacityHeight - deltaH,
      topRight.dx,
      topRight.dy,
    );
    path2.close();
    canvas.drawPath(path2, paint2);
  }
}
