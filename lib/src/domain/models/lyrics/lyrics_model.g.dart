// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsModel _$LyricsModelFromJson(Map<String, dynamic> json) {
  return LyricsModel(
    service: json['service'] as String,
    lines: (json['lines'] as List<dynamic>)
        .map((e) => LyricsLineModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LyricsModelToJson(LyricsModel instance) =>
    <String, dynamic>{
      'service': instance.service,
      'lines': instance.lines,
    };
