import 'package:flutter/material.dart';

class DrawerCustomHeader extends StatelessWidget {
  final double margin;

  const DrawerCustomHeader({
    Key key,
    this.margin,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      margin: EdgeInsets.symmetric(horizontal: margin),
      height: 200.0,
      color: Colors.blue,
    );
  }
}
