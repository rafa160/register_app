import 'package:flutter/material.dart';

class BackgroundOne extends StatelessWidget {
  final Widget child;
  final Color color;

  const BackgroundOne({Key key, this.child, this.color}) : super(key: key);
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
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset('assets/one.png',width: size.width * 0.8),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset('assets/two.png',width: size.width * 0.5,),
          ),
          child
        ],
      ),
    );
  }
}

