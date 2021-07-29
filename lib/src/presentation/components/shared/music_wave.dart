import 'package:flutter/material.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class _MusicWave extends StatefulWidget {
  int duration;
  Color color;

  _MusicWave({required this.color, required this.duration});

  @override
  __MusicWaveState createState() => __MusicWaveState();
}

class __MusicWaveState extends State<_MusicWave> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeInOutCubic);

    animation = Tween<double>(begin: 5, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: animation.value,
      decoration: BoxDecoration(color: widget.color),
    );
  }
}

class MusicVisualizer extends StatelessWidget {
  List<Color> colors = [AppColors.white, AppColors.white, AppColors.white, AppColors.white, AppColors.white];
  List<int> durations = [400, 650, 600, 450, 500];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        10,
        (index) => index % 2 == 0
            ? SizedBox(width: 2.5)
            : _MusicWave(duration: durations[index % 5], color: colors[index % 5]),
      ),
    );
  }
}
