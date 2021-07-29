import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:lyricious/src/presentation/components/shared/music_wave.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class HomePageHeader implements SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 150;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final radius = shrinkOffset == 0
        ? 30
        : shrinkOffset >= 90
            ? 0
            : 30 - (shrinkOffset * 30 / 90);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius.toDouble()),
        bottomRight: Radius.circular(radius.toDouble()),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: AppColors.primary),
          Center(
            child: Text(
              "Lyricious",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontFamily: "Comfortaa",
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 20, child: MusicVisualizer()),
                  SizedBox(width: 10),
                  Text(
                    "Скриптонит - Цепи",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Gilroy",
                    ),
                  ),
                ],
              ),
            ),
            bottom: 10,
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration => null;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  @override
  TickerProvider? get vsync => null;
}
