// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../domain/models/lyrics/lyrics_model.dart' as _i4;
import '../../presentation/pages/pages.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LauncherRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.LauncherPage();
        }),
    HomeRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.HomePage();
        }),
    LyricsRoute.name: (routeData) => _i1.CupertinoPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<LyricsRouteArgs>();
          return _i3.LyricsPage(lyrics: args.lyrics);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(LauncherRoute.name, path: '/'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i1.RouteConfig(LyricsRoute.name, path: '/lyrics-page')
      ];
}

class LauncherRoute extends _i1.PageRouteInfo {
  const LauncherRoute() : super(name, path: '/');

  static const String name = 'LauncherRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

class LyricsRoute extends _i1.PageRouteInfo<LyricsRouteArgs> {
  LyricsRoute({required _i4.LyricsModel lyrics})
      : super(name,
            path: '/lyrics-page', args: LyricsRouteArgs(lyrics: lyrics));

  static const String name = 'LyricsRoute';
}

class LyricsRouteArgs {
  const LyricsRouteArgs({required this.lyrics});

  final _i4.LyricsModel lyrics;
}
