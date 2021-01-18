import 'package:flutter/material.dart';
import 'package:personal_register/helpers/shared.dart';

class DefaultContainer extends StatelessWidget {

  final Widget child;
  final Color color;

  const DefaultContainer({this.child, this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: color == null ? Shared.standardBackgroundColor : color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
