import 'package:json_annotation/json_annotation.dart';

part 'lyrics_line_model.g.dart';

@JsonSerializable()
class LyricsLineModel {
  String text;
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
