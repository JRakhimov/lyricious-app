import 'dart:convert';

import 'package:lyricious/src/core/services/services.dart';
import 'package:lyricious/src/domain/models/models.dart';

class LyricsRepository {
  static Future<LyricsModel> getLyrics({
    required String name,
    required String artist,
    int? duration,
  }) async {
    final data = {"name": name, "artist": artist, "duration": duration};

    final response = await HttpService.dio.post("/lyrics", data: jsonEncode(data));

    if (response.data['status'] == null) {
      return LyricsModel.fromJson(response.data['lyrics']);
    }

    return LyricsModel(service: "", lines: [], withTimeCode: false);
  }
}
