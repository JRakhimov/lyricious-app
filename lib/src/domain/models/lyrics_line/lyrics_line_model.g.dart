// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsLineModel _$LyricsLineModelFromJson(Map<String, dynamic> json) {
  return LyricsLineModel(
    text: json['text'] as String,
    startTime: (json['startTime'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$LyricsLineModelToJson(LyricsLineModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'startTime': instance.startTime,
    };
