import 'package:flutter/material.dart';

class DrawerCustomButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String title;
  final IconData trailingIcon;
  final Color color;
  final double margin;
  final double size;
  const DrawerCustomButton({
    Key key,
    this.color,
    @required this.size,
    @required this.margin,
    @required this.onPressed,
    @required this.icon,
    @required this.title,
    @required this.trailingIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.red,
      child: AnimatedContainer(
        curve: Curves.easeOutQuint,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        duration: Duration(milliseconds: 500),
        margin: EdgeInsets.symmetric(horizontal: margin, vertical: 5.0),
        decoration: BoxDecoration(
          color: color ?? null,
          border: Border.all(
            width: 1.0,
            color: Colors.black,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: size + 10.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size,
                  ),
                )
              ],
            ),
            Icon(
              trailingIcon,
              size: size - 5.0,
            )
          ],
        ),
      ),
    );
  }
}
