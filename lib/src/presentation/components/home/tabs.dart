import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lyricious/src/presentation/pages/pages.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class AppTabs extends StatefulWidget {
  int activeIndex;
  List<TabOption> tabOptions;
  Function(int index) onSelect;

  AppTabs({required this.activeIndex, required this.tabOptions, required this.onSelect});

  @override
  _AppTabsState createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  double animX = -1;
  bool animEnd = true;
  final animXOffset = [-0.02, 0.01, 0.01, 0.02];

  @override
  void initState() {
    super.initState();

    // 0 = -0.75
    // 1 = -0.25
    // 2 = 0.25
    // 3 = 0.75

    currentIndex = widget.activeIndex;
    animX = (-0.75 + currentIndex * 0.5) + animXOffset[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(color: AppColors.black, borderRadius: BorderRadius.circular(30)),
      child: Stack(
        children: [
          _switchAnimation(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.tabOptions.map<Widget>((e) => _getNavItem(e)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _switchAnimation() {
    return AnimatedAlign(
      alignment: Alignment(animX, 1),
      duration: Duration(milliseconds: 200),
      onEnd: () => setState(() => animEnd = true),
      child: Container(
        width: 7.5,
        height: 7.5,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget _getNavItem(TabOption option) {
    return Expanded(
      child: InkWell(
        onTap: () => onNavigationTap(option),
        child: Container(
          height: 46,
          child: Center(
            child: Text(
              option.title,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontFamily: "Gilroy",
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onNavigationTap(TabOption option) {
    setState(() {
      currentIndex = widget.tabOptions.indexOf(option);
      animX = (-0.75 + currentIndex * 0.5) + animXOffset[currentIndex];
      animEnd = false;
    });

    widget.onSelect(widget.tabOptions.indexOf(option));

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
