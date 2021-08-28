import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lyricious/src/domain/models/models.dart';

part 'lyrics_line_model.g.dart';

@HiveType(typeId: HiveTypeIds.lyricsLine)
@JsonSerializable()
class LyricsLineModel {
  @HiveField(0)
  String text;

  @HiveField(1)
  double? startTime;

  LyricsLineModel({
    required this.text,
    this.startTime,
  });

  factory LyricsLineModel.fromJson(Map<String, dynamic> json) {
    return _$LyricsLineModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsLineModelToJson(this);
}
