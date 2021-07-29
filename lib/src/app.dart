import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyricious/src/core/router/app_router.gr.dart';
import 'package:lyricious/src/domain/cubits/app/app_cubit.dart';

import 'presentation/theme/theme.dart';

final _appRouter = AppRouter();

class LyriciousApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit()..initCubit(),
      child: MaterialApp.router(
        title: "Lyricious",
        theme: AppTheme,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
