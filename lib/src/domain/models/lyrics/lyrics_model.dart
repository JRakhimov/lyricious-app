import 'package:json_annotation/json_annotation.dart';
import 'package:lyricious/src/domain/models/models.dart';

part 'lyrics_model.g.dart';

@JsonSerializable()
class LyricsModel {
  String service;
  @JsonKey(name: "url")
  String pageUrl;
  String content;
  SongModel song;

  LyricsModel({
    required this.service,
    required this.pageUrl,
    required this.content,
    required this.song,
  });

  factory LyricsModel.fromJson(Map<String, dynamic> json) {
    return _$LyricsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsModelToJson(this);
}
