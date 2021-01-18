import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      width: size.width * 0.1,
      child: Center(
        child: FlareActor('assets/empty_not_found_404.flr', animation: "idle",fit: BoxFit.contain,)
      ),
    );
  }
}
