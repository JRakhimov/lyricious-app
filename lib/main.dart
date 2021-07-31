import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:lyricious/src/app.dart';
import 'package:lyricious/src/core/utils/utils.dart';
import 'package:lyricious/src/domain/cubits/app/app_cubit.dart';

// flutter pub run flutter_launcher_icons:main
// flutter build apk --release --no-sound-null-safety
// flutter build apk --split-per-abi --no-sound-null-safety
// flutter pub run build_runner watch --delete-conflicting-outputs

void main() async {
  await dotenv.load(fileName: ".env");

  checkEnvVariables();

  GetIt.I.registerLazySingleton<AppCubit>(() => AppCubit());

  runApp(LyriciousApp());
}
