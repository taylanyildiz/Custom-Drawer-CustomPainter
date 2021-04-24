import 'package:flutter/material.dart';

class DrawerCustomHeader extends StatelessWidget {
  final double margin;
  final Widget child;

  const DrawerCustomHeader({
    Key key,
    @required this.child,
    this.margin,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: Column(
        children: [
          child,
          Divider(
            height: 10.0,
            thickness: 2.0,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
