import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:personal_register/helpers/shared.dart';

class MainScreenPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100, left: 10, right: 10),
      color: Shared.standardBackgroundColor,
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        crossAxisCount: 4,
        itemCount: 12,
        itemBuilder: (_, index) {
          return Container(
            height: MediaQuery.of(context).size.height * 1,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [
                    Colors.white.withAlpha(150),
                    Colors.grey.withAlpha(100),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) =>
            StaggeredTile.count(
                2, index.isEven ? 1.9 : 1.4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
    );
  }
}
