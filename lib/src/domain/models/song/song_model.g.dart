// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) {
  return SongModel(
    name: json['name'] as String,
    artist: json['artist'] as String,
    album: json['album'] as String?,
    albumPic: json['albumPic'] as String?,
  );
}

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'name': instance.name,
      'artist': instance.artist,
      'album': instance.album,
      'albumPic': instance.albumPic,
    };
