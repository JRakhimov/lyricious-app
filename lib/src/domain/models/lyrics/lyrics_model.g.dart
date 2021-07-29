// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsModel _$LyricsModelFromJson(Map<String, dynamic> json) {
  return LyricsModel(
    service: json['service'] as String,
    pageUrl: json['url'] as String,
    content: json['content'] as String,
    song: SongModel.fromJson(json['song'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LyricsModelToJson(LyricsModel instance) =>
    <String, dynamic>{
      'service': instance.service,
      'url': instance.pageUrl,
      'content': instance.content,
      'song': instance.song,
    };
