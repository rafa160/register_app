import 'package:flutter/material.dart';

class BackgroundEmpty extends StatelessWidget {
  final Widget child;
  final Color color;

  const BackgroundEmpty({Key key, this.child, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: color,
      height:size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child
        ],
      ),
    );
  }
}

