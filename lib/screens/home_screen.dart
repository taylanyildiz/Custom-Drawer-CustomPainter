import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/widgets.dart';

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
  PageController _pageController;
  bool isDrawer = false;
  Offset offset = Offset(0.0, 0.0);
  GlobalKey drawerKey = GlobalKey();
  final widgets = <double>[];

  final _screens = <Widget>[
    Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'Page 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Text(
          'Page 2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          'Page 3',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Text(
          'Page 4',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    for (var i = 0; i < 5; i++) {
      widgets.add(0.0);
    }
    WidgetsBinding.instance.addPostFrameCallback(getPosition);
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  // Route _createRoute(Widget child) => PageRouteBuilder(
  //       pageBuilder: (context, animation, secondaryAnimation) => child,
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //         final offsetAnimation = animation.drive(
  //             Tween(begin: Offset(-1.0, 0.0), end: Offset.zero)
  //                 .chain(CurveTween(curve: Curves.elasticOut)));
  //         return SlideTransition(
  //           position: offsetAnimation,
  //           child: child,
  //         );
  //       },
  //     );

  getPosition(duration) {
    RenderBox renderBox = drawerKey.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    double start = position.dy - 20;
    double constWidget = position.dy + renderBox.size.height - 20;
    double step = (constWidget - start) / 4;
    widgets.clear();
    for (var i = start; i <= constWidget; i = i + step) {
      widgets.add(i);
    }
  }

  double getSize(int index) {
    final size = offset.dy > widgets[index] && offset.dy < widgets[index + 1]
        ? 25.0
        : 20.0;
    return size;
  }

  void drawerButton(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(seconds: 1),
      curve: Curves.elasticOut,
    );
    // setState(() => isDrawer = false);
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
            PageView.builder(
              controller: _pageController,
              itemCount: _screens.length,
              itemBuilder: (context, index) => _screens[index],
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
                      Container(
                        child: Column(
                          children: [
                            DrawerCustomHeader(
                              child: Container(
                                height: 200.0,
                                color: Colors.blue,
                              ),
                              margin: !isDrawer ? 20.0 : 0.0,
                            ),
                            Container(
                              key: drawerKey,
                              child: Column(
                                children: [
                                  DrawerCustomButton(
                                    margin: !isDrawer ? 20.0 : 0.0,
                                    onPressed: () => drawerButton(0),
                                    icon: Icons.person,
                                    title: 'Name',
                                    trailingIcon: Icons.more_vert,
                                    size: getSize(0),
                                  ),
                                  DrawerCustomButton(
                                    margin: !isDrawer ? 20.0 : 0.0,
                                    onPressed: () => drawerButton(1),
                                    icon: Icons.image,
                                    title: 'Select Image',
                                    trailingIcon: Icons.more_vert,
                                    size: getSize(1),
                                  ),
                                  DrawerCustomButton(
                                    margin: !isDrawer ? 20.0 : 0.0,
                                    onPressed: () => drawerButton(2),
                                    icon: Icons.settings,
                                    title: 'Setting profile',
                                    trailingIcon: Icons.more_vert,
                                    size: getSize(2),
                                  ),
                                  DrawerCustomButton(
                                    margin: !isDrawer ? 20.0 : 0.0,
                                    onPressed: () => drawerButton(3),
                                    icon: Icons.connect_without_contact,
                                    title: 'Connection',
                                    trailingIcon: Icons.more_vert,
                                    size: getSize(3),
                                  )
                                ],
                              ),
                            )
                          ],
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
