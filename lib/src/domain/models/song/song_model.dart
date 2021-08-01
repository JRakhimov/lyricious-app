import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lyricious/src/domain/models/lyrics/lyrics_model.dart';

part 'song_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class SongModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> artists;

  @HiveField(2)
  LyricsModel? lyrics;

  @HiveField(3)
  String? albumPic;

  @HiveField(4)
  int? duration;

  SongModel({
    required this.name,
    required this.artists,
    this.lyrics,
    this.albumPic,
    this.duration,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return _$SongModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}
