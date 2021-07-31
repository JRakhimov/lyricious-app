import 'package:hive_flutter/hive_flutter.dart';
import 'package:lyricious/src/domain/models/models.dart';

class MemoryRepository {
  static const LIKED_BOX = "liked";
  static const RECENTLY_BOX = "recently";

  static String generateSongKey(SongModel song) => [
        song.name.replaceAll(" ", ""),
        song.artists[0].replaceAll(" ", ""),
      ].join("_");

  static Box<SongModel> likedBox() => Hive.box<SongModel>(LIKED_BOX);

  static Box<SongModel> recentlyBox() => Hive.box<SongModel>(RECENTLY_BOX);

  static putToLiked(SongModel song) {
    Hive.box<SongModel>(LIKED_BOX).put(generateSongKey(song), song);
  }

  static removeFromLiked(SongModel song) {
    Hive.box<SongModel>(LIKED_BOX).delete(generateSongKey(song));
  }

  static SongModel? getFromLiked(String key) {
    return Hive.box<SongModel>(LIKED_BOX).get(key);
  }

  static clearLiked() {
    Hive.box<SongModel>(LIKED_BOX).clear();
  }

  static putToRecently(SongModel song) {
    Hive.box<SongModel>(RECENTLY_BOX).put(generateSongKey(song), song);
  }

  static removeFromRecently(SongModel song) {
    Hive.box<SongModel>(RECENTLY_BOX).delete(generateSongKey(song));
  }

  static SongModel? getFromRecently(String key) {
    return Hive.box<SongModel>(RECENTLY_BOX).get(key);
  }

  static clearRecently() {
    Hive.box<SongModel>(RECENTLY_BOX).clear();
  }
}
