import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyricious/src/presentation/components/components.dart';
import 'package:lyricious/src/presentation/components/home/header.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class TabOption {
  String title;
  Widget Function() bodyBuilder;

  TabOption({
    required this.title,
    required this.bodyBuilder,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TabOption> _tabOptions = [
    TabOption(title: "Liked", bodyBuilder: () => HomeLikedSection()),
    TabOption(title: "Recently", bodyBuilder: () => Container()),
    TabOption(title: "Top", bodyBuilder: () => Container()),
    TabOption(title: "Playlist", bodyBuilder: () => Container()),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(delegate: HomePageHeader()),
          SliverPadding(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  if (i == 0)
                    return AppTabs(
                      activeIndex: currentIndex,
                      tabOptions: _tabOptions,
                      onSelect: (index) => setState(() => currentIndex = index),
                    );

                  return _tabOptions[currentIndex].bodyBuilder();
                },
                childCount: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
