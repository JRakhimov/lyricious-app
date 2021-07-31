import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:lyricious/src/core/services/services.dart';
import 'package:lyricious/src/domain/models/models.dart';

class LyricsRepository {
  static Future<LyricsModel> getLyrics({required String name, required String artist}) async {
    final data = {"name": name, "artist": artist};

    final response = await HttpService.dio.post("/lyrics", data: jsonEncode(data));

    if (response.data['status'] == null) {
      final lyrics = LyricsModel.fromJson(response.data['lyrics']);

      Hive.box<SongModel>("recently").put(
        "${name}_$artist",
        SongModel(name: name, artists: [artist], lyrics: lyrics),
      );

      return lyrics;
    }

    return LyricsModel(service: "", lines: []);
  }
}
