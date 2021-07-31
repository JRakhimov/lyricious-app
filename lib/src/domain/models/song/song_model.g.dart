// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) {
  return SongModel(
    name: json['name'] as String,
    artists:
        (json['artists'] as List<dynamic>).map((e) => e as String).toList(),
    lyrics: json['lyrics'] == null
        ? null
        : LyricsModel.fromJson(json['lyrics'] as Map<String, dynamic>),
    albumPic: json['albumPic'] as String?,
  );
}

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'name': instance.name,
      'artists': instance.artists,
      'lyrics': instance.lyrics,
      'albumPic': instance.albumPic,
    };
