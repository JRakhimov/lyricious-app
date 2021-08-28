import 'package:hive_flutter/hive_flutter.dart';
import 'package:lyricious/src/domain/models/hive_song/hive_song_model.dart';
import 'package:lyricious/src/domain/models/models.dart';
import 'package:translit/translit.dart';

class MemoryRepository {
  static const LIKED_BOX = "liked";
  static const RECENTLY_BOX = "recently";

  static String generateSongKey(SongModel song) {
    final key = [
      song.name.replaceAll(" ", ""),
      song.artists[0].replaceAll(" ", ""),
    ].join("_");

    return Translit().toTranslit(source: key).substring(0, key.length > 255 ? 255 : key.length);
  }

  static Box<HiveSongModel> likedBox() => Hive.box<HiveSongModel>(LIKED_BOX);

  static Box<HiveSongModel> recentlyBox() => Hive.box<HiveSongModel>(RECENTLY_BOX);

  static putToLiked(SongModel song) {
    Hive.box<HiveSongModel>(LIKED_BOX).put(
      generateSongKey(song),
      HiveSongModel(actionDate: DateTime.now(), song: song),
    );
  }

  static removeFromLiked(SongModel song) {
    Hive.box<SongModel>(LIKED_BOX).delete(generateSongKey(song));
  }

  static HiveSongModel? getFromLiked(String key) {
    return Hive.box<HiveSongModel>(LIKED_BOX).get(key);
  }

  static clearLiked() {
    Hive.box<HiveSongModel>(LIKED_BOX).clear();
  }

  static putToRecently(SongModel song) {
    Hive.box<HiveSongModel>(RECENTLY_BOX).put(
      generateSongKey(song),
      HiveSongModel(actionDate: DateTime.now(), song: song),
    );
  }

  static removeFromRecently(SongModel song) {
    Hive.box<HiveSongModel>(RECENTLY_BOX).delete(generateSongKey(song));
  }

  static HiveSongModel? getFromRecently(String key) {
    return Hive.box<HiveSongModel>(RECENTLY_BOX).get(key);
  }

  static clearRecently() {
    Hive.box<HiveSongModel>(RECENTLY_BOX).clear();
  }
}
