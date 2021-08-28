import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lyricious/src/domain/models/lyrics/lyrics_model.dart';
import 'package:lyricious/src/domain/models/models.dart';

part 'song_model.g.dart';

@HiveType(typeId: HiveTypeIds.song)
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
