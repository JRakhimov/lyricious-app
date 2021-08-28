import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lyricious/src/domain/models/models.dart';

part 'hive_song_model.g.dart';

@HiveType(typeId: HiveTypeIds.hiveSong)
@JsonSerializable()
class HiveSongModel {
  @HiveField(0)
  DateTime actionDate;

  @HiveField(1)
  SongModel song;

  HiveSongModel({
    required this.actionDate,
    required this.song,
  });

  factory HiveSongModel.fromJson(Map<String, dynamic> json) {
    return _$HiveSongModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HiveSongModelToJson(this);
}
