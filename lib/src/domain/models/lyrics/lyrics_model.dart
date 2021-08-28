import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lyricious/src/domain/models/models.dart';

part 'lyrics_model.g.dart';

@HiveType(typeId: HiveTypeIds.lyrics)
@JsonSerializable()
class LyricsModel {
  @HiveField(0)
  String service;

  @HiveField(1)
  List<LyricsLineModel> lines;

  @HiveField(2)
  bool withTimeCode;

  LyricsModel({
    required this.service,
    required this.lines,
    required this.withTimeCode,
  });

  factory LyricsModel.fromJson(Map<String, dynamic> json) {
    return _$LyricsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsModelToJson(this);
}
