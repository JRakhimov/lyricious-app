import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lyricious/src/app.dart';
import 'package:lyricious/src/core/utils/utils.dart';
import 'package:lyricious/src/domain/cubits/app/app_cubit.dart';
import 'package:lyricious/src/domain/models/models.dart';

// flutter pub run flutter_launcher_icons:main
// flutter build apk --release --no-sound-null-safety
// flutter build apk --split-per-abi --no-sound-null-safety
// flutter pub run build_runner watch --delete-conflicting-outputs

void main() async {
  await dotenv.load(fileName: ".env");

  checkEnvVariables();

  await Hive.initFlutter();

  Hive.registerAdapter(SongModelAdapter());
  Hive.registerAdapter(LyricsModelAdapter());
  Hive.registerAdapter(LyricsLineModelAdapter());

  await Hive.openBox<SongModel>("recently");
  await Hive.openBox<SongModel>("liked");

  GetIt.I.registerLazySingleton<AppCubit>(() => AppCubit());

  runApp(LyriciousApp());
}
