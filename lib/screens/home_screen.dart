import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({
    Key key,
    @required this.title,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawer = false;
  Offset offset = Offset(0.0, 0.0);

  void nextPaga() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final drawerWidth = width * .65;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  'Page Drawer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              left: !isDrawer ? -drawerWidth + 20 : 0.0,
              child: SizedBox(
                width: drawerWidth,
                child: GestureDetector(
                  onPanUpdate: (detail) {
                    if (detail.localPosition.dx <= drawerWidth)
                      setState(() => offset = detail.localPosition);
                    if (detail.localPosition.dx > drawerWidth - 20 &&
                        detail.delta.distanceSquared > 2)
                      setState(() => isDrawer = true);
                  },
                  onPanEnd: (detail) {
                    setState(() => offset = Offset(0.0, 0.0));
                  },
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(drawerWidth, height),
                        painter: CustomDrawer(
                          offset: offset,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              bottom: 40.0,
              left: !isDrawer ? 0.0 : drawerWidth - 20,
              child: GestureDetector(
                onTap: () => setState(() => isDrawer = !isDrawer),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    !isDrawer ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends CustomPainter {
  final Paint drawerPaint;
  final Color color;
  final Offset offset;
  CustomDrawer({
    @required this.offset,
    Animation animation,
    this.color = Colors.white,
  })  : drawerPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = color
          ..strokeWidth = 10.0,
        super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    drawDrawer(canvas, size);
  }

  void drawDrawer(Canvas canvas, Size size) {
    Path path = createPath(size);
    canvas.drawPath(path, drawerPaint);
  }

  double getControlPointX(double width) {
    if (offset.dx == 0) {
      return width;
    } else {
      return offset.dx > width ? offset.dx : width + 75;
    }
  }

  Path createPath(Size size) {
    Path path = Path();
    path.moveTo(-size.width, 0.0);
    path.lineTo(size.width, 0.0);
    path.quadraticBezierTo(
      getControlPointX(size.width),
      offset.dy,
      size.width,
      size.height,
    );
    path.lineTo(-size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
