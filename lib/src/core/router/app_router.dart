import 'package:auto_route/auto_route.dart';
import 'package:lyricious/src/presentation/pages/pages.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LauncherPage, initial: true),
    AutoRoute(page: HomePage),
    AutoRoute(page: LyricsPage),
  ],
)
class $AppRouter {}
