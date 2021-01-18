import 'package:flutter/material.dart';

class AnimationButton extends StatelessWidget {
  final AnimationController controller;

  AnimationButton({this.controller})
      : buttonAnimation = Tween(begin: 320.0, end: 50.0).animate(
    CurvedAnimation(parent: controller, curve: Interval(0, 0.150)),
  ),
        buttonZoomOut = Tween(begin: 60.0, end: 1000.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1, curve: Curves.bounceInOut),
          ),
        );

  final Animation<double> buttonAnimation;
  final Animation<double> buttonZoomOut;

  //mesmo que nao va utilizar o child ]e preciso chamar o widget child
  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 50,
      ),
      child: InkWell(
        onTap: () {
          controller.forward();
        },
        child: Hero(
          tag: "fade",
          child: buttonZoomOut.value <= 70
              ? Container(
              width: buttonAnimation.value,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
//              353659
                  color: Color.fromRGBO(35, 36, 59, 1),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: _buildInside(context))
              : Container(
            width: buttonZoomOut.value,
            height: buttonZoomOut.value,
            decoration: BoxDecoration(
              color: Color.fromRGBO(35, 36, 59, 1),
              shape: buttonZoomOut.value < 500
                  ? BoxShape.circle
                  : BoxShape.rectangle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInside(BuildContext context) {
    if (buttonAnimation.value > 70) {
      return Text(
        "Entrar",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
