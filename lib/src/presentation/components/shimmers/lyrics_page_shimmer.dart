import 'package:flutter/material.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class LyricsPageShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(color: AppColors.black, borderRadius: BorderRadius.circular(30));

    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Column(children: [
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(12.5),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 13.5,
                      width: 125,
                      decoration: decoration,
                    ),
                    SizedBox(height: 12.5),
                    Container(
                      height: 12,
                      width: 200,
                      decoration: decoration,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 30),
        Expanded(child: Container(decoration: decoration))
      ]),
    );
  }
}
