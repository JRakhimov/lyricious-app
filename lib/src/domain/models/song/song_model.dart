import 'package:json_annotation/json_annotation.dart';
import 'package:lyricious/src/domain/models/lyrics/lyrics_model.dart';

part 'song_model.g.dart';

@JsonSerializable()
class SongModel {
  String name;
  List<String> artists;
  LyricsModel? lyrics;
  String? albumPic;

  SongModel({
    required this.name,
    required this.artists,
    this.lyrics,
    this.albumPic,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return _$SongModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}
