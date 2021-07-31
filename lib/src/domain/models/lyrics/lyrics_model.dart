import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lyricious/src/domain/models/models.dart';

part 'lyrics_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class LyricsModel {
  @HiveField(0)
  String service;

  @HiveField(1)
  List<LyricsLineModel> lines;

  LyricsModel({
    required this.service,
    required this.lines,
  });

  factory LyricsModel.fromJson(Map<String, dynamic> json) {
    return _$LyricsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsModelToJson(this);
}
