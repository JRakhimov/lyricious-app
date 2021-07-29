import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lyricious/src/core/router/app_router.gr.dart';
import 'package:lyricious/src/presentation/theme/colors.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 1500)).then((_) => AutoRouter.of(context).replace(HomeRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: Center(
          child: Image(
            image: AssetImage('assets/images/lyricious_transparent_text.png'),
            height: 65,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
