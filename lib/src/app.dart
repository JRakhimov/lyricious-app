import 'package:flutter/material.dart';
import 'package:lyricious/src/core/router/app_router.gr.dart';

import 'presentation/theme/theme.dart';

final _appRouter = AppRouter();

class LyriciousApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Lyricious",
      theme: AppTheme,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
